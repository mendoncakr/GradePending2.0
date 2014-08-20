class RestaurantsController < ApplicationController

	def index
		respond_to do |format|
			format.html
			format.json {render json: Hash[Restaurant.all.pluck(:name, :id)]}
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def search 
		if params["search"]
			result = Restaurant.search(params["search"].upcase)
			p result
			redirect_to root_path
		end
		
	end

end

