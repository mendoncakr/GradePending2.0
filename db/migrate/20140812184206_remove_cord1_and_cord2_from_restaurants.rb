class RemoveCord1AndCord2FromRestaurants < ActiveRecord::Migration
  def change
	  	remove_column :restaurants, :cord1, :float
	  	remove_column :restaurants, :cord2, :float
  end
end
