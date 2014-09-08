class Addcurrentgradetorestaurant < ActiveRecord::Migration
  def change
  	add_column :restaurants, :current_grade, :string
  end
end
