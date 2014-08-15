class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.first(1000)
    @hash = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      @restaurant = restaurant.phone
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow render_to_string(:partial => "/restaurants/info", :locals => { :object => @restaurant})
      marker.json({:name=> restaurant.name})
    end
  end
end

