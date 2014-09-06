class FavoriteRestaurant < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant
	validates_uniqueness_of :restaurant_id
end
