class Restaurant < ActiveRecord::Base
  has_many :inspections
  validates_uniqueness_of :phone

  def address
  	"#{self.building} " + "#{self.street} " + "#{self.zipcode}"
  end

end
