RestaurantMapController < ApplicationController
	
	def find
		@restuarant = Restaurant.find(params[:id])
		{latitude: @restuarant.latitude longitude: @resturant.longitude}.to_json
	end
end