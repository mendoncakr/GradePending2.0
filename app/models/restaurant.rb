class Restaurant < ActiveRecord::Base
  has_many :inspections
  has_many :favorite_restaurants
  has_many :favorited_by, through: :favorite_restaurants, source: :user

  validates_uniqueness_of :phone
  geocoded_by :address
  
  scope :manhattan, -> { Restaurant.where(zipcode:  ["10026", "10027", "10030", "10037", "10039", "10001", "10011", "10018", "10019", "10020", "10036", "10029", "10035", "10010", "10016", "10017", "10022", "10012", "10013", "10014", "10004", "10005", "10006", "10007", "10038", "10280,", "10002", "10003", "10009", "10021", "10028", "10044", "10128", "10023", "10024", "10025", "10031", "10032", "10033", "10034", "10040"]
) }


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

  def current_grade
    Inspection.where(restaurant_id: self.id).order(grade_date: :desc).first.current_grade
  end

  def last_inspection_date
    self.inspections.order(inspection_date: :desc).first.inspection_date
  end

  def last_inspections
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
      "04J" => "Unprotected food re-served."
    }
    violations = []
    Inspection.where(inspection_date: self.last_inspection_date, restaurant_id: self.id).each do |i|
      violations << violation_codes[i.violation_code]
    end
    violations
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


  # Yelp reviews
  def yelp_response
    @response  ||= Yelp.client.business(self.yelp_biz_id)
  end

  def top_yelp_review
    yelp_response.reviews.first.excerpt
  end

  def yelp_review_user
    yelp_response.reviews.first.user.name
  end

  def yelp_review_user_image
    yelp_response.reviews.first.user.image_url
  end

  def yelp_review_rating_url
    yelp_response.reviews.first.rating_image_large_url
  end
  
  def yelp_biz_id
    @client_response ||= Yelp.client.search(self.borough, self.restaurant_name)
    @client_response.businesses[0] == nil ?  -99999999 : @client_response.businesses[0].id 
 end
end
