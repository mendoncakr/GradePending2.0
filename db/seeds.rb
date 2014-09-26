require 'csv'

inspection_counter = 0
restaurant_counter = 0

# CREATE RESTAURANTS AND THEIR INSPECTIONS
file = File.expand_path('../../public/WebExtract2.csv', __FILE__)
CSV.parse(File.open(file, 'r:iso-8859-1:utf-8'){|f| f.read}, col_sep: ',', headers: true) do |row|
	row = row.to_hash
	if Chronic.parse(row["INSPDATE"]) >= Chronic.parse("January 1, 2014")
		r = Restaurant.create(
			name: row["DBA"],
			boro: row["BORO"],
			building: row["BUILDING"],
			street: row["STREET"],
			zipcode: row["ZIPCODE"],
			phone: row["PHONE"],
			cuisine_code: row["CUISINECODE"]
			)
		p restaurant_counter += 1
		i = Inspection.create(
			phone: row["PHONE"],
			inspection_date: Chronic.parse(row["INSPDATE"]),
			action: row["ACTION"],
			violation_code: row["VIOLCODE"],
			score: row["SCORE"],
			current_grade: row["CURRENTGRADE"],
			grade_date: Chronic.parse(row["GRADEDATE"]),
			record_date: Chronic.parse(row["RECORDDATE"])
			)
	end
end
 																												

# ADD INSPECTIONS TO THEIR RESPECTIVE RESTAURANTS
counter = 0
Inspection.where(restaurant_id: nil).find_each(batch_size: 5000) do |ins|
	p ins.phone
	r = Restaurant.find_by(phone: ins.phone)
	r.inspections << ins
	p counter
	counter += 1
end
	


