class Restaurant < ActiveRecord::Base
  has_many :inspections
  validates_uniqueness_of :phone
  geocoded_by :address


  def address
  	"#{self.building} " + "#{self.street} " + "#{self.zipcode}"
  end

  def save_coords
  	coords = Geocoder.coordinates(self.address)
  	self.coord1 = coords[0]
  	self.coord2 = coords[1]
  	self.save
  end

end
