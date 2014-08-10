class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :boro
      t.string :building
      t.string :street
      t.string :zipcode
      t.string :phone
      t.string :cuisine_code

      t.timestamps
    end
      add_index :restaurants, [:zipcode, :name]
  end
end
