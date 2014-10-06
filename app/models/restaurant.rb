class Restaurant < ActiveRecord::Base
  has_many :inspections
  has_many :favorite_restaurants
  has_many :favorited_by, through: :favorite_restaurants, source: :user
  attr_accessor :borough 
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
    Inspection.joins(:restaurant).where("inspections.restaurant_id = ?", self.id).order(inspection_date: :desc).map{|i| Inspection::VIOLATION_CODES[i.violation_code]}.compact!
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
