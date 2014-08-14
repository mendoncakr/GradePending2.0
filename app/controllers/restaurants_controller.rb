class RestaurantsController < ApplicationController
  def index
    # @restaurants = Restaurant.manhattan
    # @hash = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
    #   @restaurant = restaurant.phone
    #   marker.lat restaurant.latitude
    #   marker.lng restaurant.longitude
    #   marker.infowindow render_to_string(:partial => "/restaurants/info", :locals => { :object => @restaurant})
    #   marker.json({:name=> restaurant.name})
    # end

    # client = SODA::Client.new({:domain => "explore.data.gov", :app_token => ENV['SODA_API_KEY']})
    # p resonse = client.get("4vkw-7nck?")
  end
end

