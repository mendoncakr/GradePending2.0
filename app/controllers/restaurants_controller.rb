class RestaurantsController < ApplicationController
	before_action :authenticate_user!, :only => [:favorite]

	def index
		@enable_nav = false
		respond_to do |format|
			format.html
			format.json {render json: Hash[Restaurant.all.pluck(:name, :id)]}
		end
	end
	
	def statistics
		@enable_nav = true
		grades  = Restaurant.all.pluck(:current_grade)
		a =  grades.select{|x| x == 'A'}.size
		b = grades.select{|x| x == 'B'}.size
		c = grades.select{|x| x == 'C'}.size
		gp = grades.select{|x| x == 'Z'}.size
		no_grade = grades.select{|x| x == nil}.size
		total = grades.size
		respond_to do |format|
			format.json {render json: {a: a, b: b, c: c, gp: gp, no_grade: no_grade, total: total}}
			format.html
		end
	end

	def show
		@enable_nav = true
		@restaurant = Restaurant.find(params[:id])
		@nearby = @restaurant.find_nearby
		respond_to do |format|
			format.html
			format.json {render json: { name: @restaurant.name, restaurant: @restaurant.id, latitude: @restaurant.latitude, longitude: @restaurant.longitude } }
		end
	end

	def search 
		if params["search"]
			result = Restaurant.search(params["search"].upcase)
			redirect_to root_path
		end
	end

	def favorite
		@enable_nav = true
		@restaurant = Restaurant.find(params[:id])
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

