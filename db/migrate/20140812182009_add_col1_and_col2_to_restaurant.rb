class AddCol1AndCol2ToRestaurant < ActiveRecord::Migration
  def change
  		add_column :restaurants, :cord1, :float
  		add_column :restaurants, :cord2, :float
  end
end
