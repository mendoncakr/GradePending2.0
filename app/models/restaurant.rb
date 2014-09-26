class Restaurant < ActiveRecord::Base
  has_many :inspections
  has_many :favorite_restaurants
  has_many :favorited_by, through: :favorite_restaurants, source: :user

  validates_uniqueness_of :phone
  geocoded_by :address

  def self.names_and_ids_cache
    Rails.cache.fetch('names_and_ids') { all.pluck(:name, :id) }
  end

  def address
  	"#{self.building} " + "#{self.street.strip} " +  "#{self.borough} " + "#{self.zipcode}"
  end

  def street_address
    "#{self.building} " + "#{self.street.strip.titleize}"
  end

  def boro_and_zip
    "#{self.borough}, " + "#{self.zipcode}"
  end

  def save_coords
  	coords = Geocoder.coordinates(self.address)
  	self.latitude = coords[0]
  	self.longitude = coords[1]
  	self.save
  end

  def grade
    Inspection.where(restaurant_id: self.id).order(grade_date: :desc).each do |r|
      return r.current_grade unless r.current_grade == nil
    end
  end

  def time_since_inspection
    seconds = Time.now - self.last_inspection_date
    (seconds / 604800).round
  end

  def last_inspection_date
    self.inspections.order(inspection_date: :desc).first.inspection_date
  end

  def last_violations
    violation_codes = {
      "01B" => "Current valid permit, registration or other authorization to operate Temporary Food Service Establishment is not available.",
      "01C" => "Notice of the Department or Board mutilated, obstructed, or removed.",
      "01D" => "Failure to comply with an Order of the Board, Commissioner or Department.",
      "01E" => "Document issued by the Board, Commissioner or Department unlawfully reproduced or altered.",
      "01F" => "Failure to report occurrences of suspected food borne illness to the Department.",
      "01G" => "Failure to comply with an Order of the Board, Commissioner or Department.",
      "01H" => "Duties of an officer of the Department interfered with or obstructed.",
      "02A" => "Food not cooked to required minimum temperature.",
      "02B" => "Hot food not held at or above 140°F.",
      "02C" => "Hot food that has been cooked and refrigerated is being held for service without first being reheated to 165°F or above within 2 hours.",
      "02D" => "Precooked potentially hazardous food from commercial food processing establishment that is to be heated, is not heated to 140°F within 2 hours.",
      "02E" => "Whole frozen poultry or poultry breasts, other than a single portion, are being cooked frozen or partially thawed.",
      "02F" => "Meat, fish or molluscan shellfish served raw or undercooked without prior notification to customer.",
      "02G" => "Cold food held above 41°F (smoked fish above 38°F) except during necessary preparation.",
      "02H" => "Food not cooled by an approved method whereby the internal product temperature is reduced from 140°F to 70°F or less within 2 hours and from 70°F to 45°F or less within 4 additional hours.",
      "02I" => "Food prepared from ingredients at ambient temperature not cooled to 41°F or below within 4 hours.",
      "02J" => "Reduced oxygen packaged (ROP) foods not cooled by an approved method whereby the internal food temperature is reduced to 38º F within two hours of cooking and if necessary further cooled to a temperature of 34º F within six hours of reaching 38º F.",
      "03A" => "Food from unapproved or unknown source, spoiled, adulterated, or home canned.",
      "03B" => "Shellfish not from approved source, improperly tagged/labeled; tags not retained for 90 days.",
      "03C" => "Eggs found dirty, cracked; liquid, frozen or powdered eggs not pasteurized.",
      "03D" => "Canned food product observed swollen, leaking, rusted, severely dented.",
      "03E" => "Potable water system inadequate. Water or ice not potable or from unapproved source. Cross connection in potable water supply system observed.",
      "03F" => "Unpasteurized milk or milk product present.",
      "03G" => "Raw food not properly washed prior to serving.",
      "04A" => "Food Protection Certificate not held by supervisor of food operations.",
      "04B" => "Food worker prepares food or handles utensil when ill with a disease transmissible by food, or have exposed infected cut or burn on their hand.",
      "04C" => "Food worker does not use proper utensil to eliminate bare hand contact with food that will not receive adequate additional heat treatment.",
      "04D" => "Food worker does not wash hands thoroughly after visiting the toilet, coughing, sneezing, smoking, preparing raw foods or otherwise contaminating hands.",
      "04E" => "Toxic chemical improperly labeled, stored or used so that contamination of food may occur.",
      "04F" => "Food, food preparation area, food storage area, area used by employees or patrons, contaminated by sewage or liquid waste.",
      "04G" => "Unprotected potentially hazardous food re-served.",
      "04H" => "Food in contact with utensil, container, or pipe that consist of toxic material.",
      "04I" => "Cooked or prepared food is cross-contaminated.",
      "04J" => "Unprotected food re-served.",
      "04K" => "Appropriately scaled metal stem-type thermometer not provided or used to evaluate temperatures of potentially hazardous foods during cooking, cooling, reheating and holding.",
      "04L" => "Evidence of rats or live rats present in facility's food and/or non-food areas.",
      "04M" => "Evidence of mice or live mice present in facility's food and/or non-food areas.",
      "04N" => "Evidence of roaches or live roaches present in facility's food and/or non-food areas.",
      "04O" => "Evidence of flying insects or live flying insects present in facility's food and/or non-food areas.",
      "04P" => "Other live animal present in facility's food and/or non-food areas.",
      "05A" => "Sewage disposal system improper or unapproved.",
      "05B" => "Harmful, noxious gas or vapor detected. CO > 13 ppm.",
      "05C" => "Food contact surface improperly constructed or located. Unacceptable material used.",
      "05D" => "Hand washing facility not provided in or near food preparation area and toilet room. Hot and cold running water at adequate pressure not provided at facility. Soap and an acceptable hand-drying device not provided.",
      "05E" => "Toilet facility not provided for employees or for patrons when required.",
      "05F" => "Refrigerated or hot holding equipment to keep potentially hazardous foods at required temperatures not provided.",
      "05G" => "Sufficient refrigerated or hot holding equipment not provided to meet proper time and temperature requirements for potentially hazardous foods.",
      "05H" => "Properly enclosed service/maintenance area not provided.",
      "05I" => "No facility available to wash, rinse, and sanitize utensils and/or equipment not provided.",
      "05J" => "Nuisance created or allowed to exist. Facility not free from unsafe, hazardous, offensive or annoying condition.",
      "06A" => "Personal cleanliness inadequate. Outer garment soiled with possible contaminant.  Effective hair restraint not worn in an area where food is prepared.",
      "06B" => "Tobacco use, eating, drinking in food preparation, food storage or dishwashing area observed.",
      "06C" => "Food not protected from potential source of contamination during storage, preparation, transportation, display or service.",
      "06F" => "Wiping cloths dirty or not stored in sanitizing solution.",
      "07A" => "Sewage disposal system improper or unapproved.",
      "07B" => "Garbage receptacles not provided or inadequate. Garbage storage area not properly constructed or maintained; grinder or compactor dirty.",
      "07F" => "Personal Hygiene and other food protection",
      "08A" => "Facility not vermin proof. Harborage or conditions conducive to vermin exist.",
      "08B" => "Tobacco use, eating, drinking in food preparation, food storage or dishwashing area observed.",
      "09A" => "Canned food product observed severely dented.",
      "09B" => "Milk or milk product undated, improperly dated or expired.",
      "09C" => "Thawing procedures improper.",
      "09D" => "Food contact surface not properly maintained."
    }
    violations = []
    Inspection.where(inspection_date: self.last_inspection_date, restaurant_id: self.id).each do |i|
      violations << violation_codes[i.violation_code]
    end
    violations.compact!
  end


  def self.search(params)
    where("name like ?", "#{params}")
  end

  def fix_name
    self.name = self.name.gsub /&amp;/, "&"
    self.save
  end

  def restaurant_name
    {term: self.name}
  end

  def borough
    case self.boro
    when "1"
      return "Manhattan"
    when "2"
      return "The Bronx"
    when "3"
      return "Brooklyn"
    when "4"
      return "Queens"
    when "5"
      return "Staten Island"
    end
  end

  def find_nearby
    restaurant_coordiantes = [self.latitude, self.longitude]
    bounds = Geokit::Bounds.from_point_and_radius(restaurant_coordiantes, 0.25)
    restaurants = Restaurant.find_by_sql(['select * from restaurants where latitude >= ? AND longitude >= ? AND latitude <= ? AND longitude <= ? AND cuisine_code = ? LIMIT 10', bounds.sw.lat, bounds.sw.lng, bounds.ne.lat, bounds.ne.lng, self.cuisine_code])
  end

  def find_all_with_cusine_code
    Restaurant.where(cuisine_code: self.cuisine_code).pluck(:current_grade)
  end

end
