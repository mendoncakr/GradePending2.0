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
		respond_to do |format|
			format.html
			format.json {render json: { restaurant: @restaurant.id, user: current_user.id } }
		end
	end

	def search 
		if params["search"]
			result = Restaurant.search(params["search"].upcase)
			redirect_to root_path
		end
	end

	def favorite
		@restaurant =  Restaurant.find(params[:id])
		@favorite = FavoriteRestaurant.new(user_id: current_user.id, restaurant_id: @restaurant.id)
		if @favorite.valid?
			@favorite.save
			# flash[:notice] = "Added to your favorites!"
			redirect_to :back
		else
			# flash[:notice] = "Already in your favorites!"
			redirect_to :back
		end
	end
end

