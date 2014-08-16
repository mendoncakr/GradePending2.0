class RestaurantsController < ApplicationController
  def index
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def search 
   result = Restaurant.search(params["search"].upcase)
   p result
   redirect_to root_path
  end
end

