class Restaurant < ActiveRecord::Base
  has_many :inspections
  validates_uniqueness_of :phone
  geocoded_by :address
  scope :manhattan, -> { Restaurant.where(zipcode:  ["10026", "10027", "10030", "10037", "10039", "10001", "10011", "10018", "10019", "10020", "10036", "10029", "10035", "10010", "10016", "10017", "10022", "10012", "10013", "10014", "10004", "10005", "10006", "10007", "10038", "10280,", "10002", "10003", "10009", "10021", "10028", "10044", "10128", "10023", "10024", "10025", "10031", "10032", "10033", "10034", "10040"]
) }


  def address
  	"#{self.building} " + "#{self.street.strip} "+ "#{self.borough} " + "#{self.zipcode}"
  end

  def save_coords
  	coords = Geocoder.coordinates(self.address)
  	self.latitude = coords[0]
  	self.longitude = coords[1]
  	self.save
  end

  def current_grade
    Inspection.where(restaurant_id: self.id).order(grade_date: :asc).first.current_grade
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
