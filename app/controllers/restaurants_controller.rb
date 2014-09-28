class RestaurantsController < ApplicationController
	include RestaurantsHelper
	before_action :authenticate_user!, :only => [:favorite]

	def index
		@enable_nav = false
		respond_to do |format|
			format.html
			format.json {render json: Hash[Restaurant.names_and_ids_cache]}
		end
	end

	def statistics
		@enable_nav = true
		grades = Restaurant.all.pluck(:current_grade)
		inspection_list = {}
		Inspection.violation_cache.each do |i|
			inspection_list.has_key?(i) ? (inspection_list[i] += 1) : (inspection_list[i] = 1)
		end
		grade_count = {}
		grades.each do |grade|
			grade_count.has_key?(grade) ? (grade_count[grade] += 1) : (grade_count[grade] = 1)
		end
		grade_count['total'] = grades.size
		respond_to do |format|
			format.json {render json:  {grades: grade_count, inspections: inspection_list}}
			format.html
		end
	end
	
	def search
		@enable_nav = true
		if params["search"]
			@result = Restaurant.basic_search(name: params["search"].upcase).paginate(:page => params[:page], :per_page => 20)
			if @result.size == 1 
				redirect_to restaurants_show_path(@result.first.id, format: :html)
			end
			
		end
	end

	def show
		@enable_nav = true
		@restaurant = Restaurant.find(params[:id])
		@nearby = @restaurant.find_nearby
		@restaurant_cuisine = cuisine_codes_hash(@restaurant.cuisine_code)
		grade_count = @restaurant.find_all_with_cusine_code
		similar_grades = {}
		grade_count.each do |i|
			i = "No Grade" if i == nil
			similar_grades.has_key?(i) ? (similar_grades[i] += 1) : (similar_grades[i] = 1)
		end

		respond_to do |format|
			format.html
			format.json {render json: {
				name: @restaurant.name.titleize,
				restaurant: @restaurant.id,
				latitude: @restaurant.latitude,
				longitude: @restaurant.longitude,
				grades: similar_grades,
				code: @restaurant_cuisine
				}}
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

