class Restaurant < ActiveRecord::Base
  has_many :inspections
  validates_uniqueness_of :phone
  geocoded_by :address


  def address
  	"#{self.building} " + "#{self.street.strip} " + "#{self.zipcode}"
  end

  def save_coords
  	coords = Geocoder.coordinates(self.address)
  	self.latitude = coords[0]
  	self.longitude = coords[1]
  	self.save
  end

end
