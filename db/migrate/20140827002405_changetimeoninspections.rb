class Changetimeoninspections < ActiveRecord::Migration
  def change
  	remove_column :inspections, :inspection_date, :string
  	remove_column :inspections, :grade_date, :string
  	remove_column :inspections, :record_date, :string
  	add_column :inspections, :inspection_date, :datetime
  	add_column :inspections, :grade_date, :datetime
  	add_column :inspections, :record_date, :datetime
  end
end
