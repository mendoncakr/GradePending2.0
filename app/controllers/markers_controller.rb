class MarkersController < ApplicationController
	def index
	end
	
	def markers
		render json: { restaurants: Restaurant.all.pluck(:latitude, :longitude)}.to_json
	end

end