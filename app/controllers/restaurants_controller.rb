class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.where.not(latitude: nil)
    @hash = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      @restaurant = restaurant.name
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow render_to_string(:partial => "/restaurants/info", :locals => { :object => @restaurant})
      marker.json({:name=> restaurant.name})
    end
  end
end