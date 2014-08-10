class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.string :inspection_date
      t.string :action
      t.string :violation_code
      t.string :score
      t.string :current_grade
      t.string :grade_date
      t.string :record_date
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
