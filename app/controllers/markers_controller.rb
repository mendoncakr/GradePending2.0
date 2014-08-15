class MarkersController < ApplicationController
	def index
	end
	
	def markers
		render json: { restaurants: Restaurant.manhattan.pluck(:name, :latitude, :longitude, :id)}.to_json
	end

end