class RestaurantsController < ApplicationController
  def index
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def search 
    Restaurant.
  end
end

