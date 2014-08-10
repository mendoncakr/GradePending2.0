class AddPhoneNumbertoInspections < ActiveRecord::Migration
  def change
  	add_column :inspections, :phone, :string
  end
end
