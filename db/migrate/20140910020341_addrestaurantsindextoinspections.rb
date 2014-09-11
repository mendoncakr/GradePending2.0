class Addrestaurantsindextoinspections < ActiveRecord::Migration
  def change
  	add_index :inspections, :restaurant_id
  end
end
