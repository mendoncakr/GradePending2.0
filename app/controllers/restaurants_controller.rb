class RestaurantsController < ApplicationController
	before_action :authenticate_user!, :only => [:favorite]

	def index
		respond_to do |format|
			format.html
			format.json {render json: Restaurant.all.pluck(:name)}
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
		p params
	end

	def search 
		if params["search"]
			result = Restaurant.search(params["search"].upcase)
			redirect_to root_path
		end
	end

	def favorite
		@restaurant =  Restaurant.find(params[:id])
		@favorite = FavoriteRestaurant.create(user_id: current_user.id, restaurant_id: @restaurant.id)
	end
end

