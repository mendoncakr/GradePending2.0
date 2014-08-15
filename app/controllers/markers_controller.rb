class MarkersController < ApplicationController
	def index
	end
	
	def markers
		render json: { restaurants: Restaurant.manhattan.pluck(:name, :latitude, :longitude)}.to_json
	end

end