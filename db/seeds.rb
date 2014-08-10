require 'csv'
file = File.expand_path('../../public/WebExtract2.csv', __FILE__)
CSV.parse(File.open(file, 'r:iso-8859-1:utf-8'){|f| f.read}, col_sep: ',', headers: true) do |row|
	row = row.to_hash

# 	r = Restaurant.new(
# 		name: row["DBA"],
# 		boro: row["BORO"],
# 		building: row["BUILDING"],
# 		street: row["STREET"],
# 		zipcode: row["ZIPCODE"],
# 		phone: row["PHONE"],
# 		cuisine_code: row["CUISINECODE"]
# 		)
# r.save
# restaurant = Restaurant.find_by(phone:phone: row["PHONE"])

# i = Inspection.create(
# 	phone: row["PHONE"],
# 	inspection_date: row["INSPDATE"],
# 	action: row["ACTION"],
# 	violation_code: row["VIOLCODE"],
# 	score: row["SCORE"],
# 	current_grade: row["CURRENTGRADE"],
# 	grade_date: row["GRADEDATE"],
# 	record_date: row["RECORDDATE"]
# 	)

end
# r = Restaurant.all
i = Inspection.where(restaurant_id: nil)

# r.each do |rest|
# 	i.each do |insp|
# 		if rest.phone == insp.phone
# 			rest.inspections << insp
# 		end
# 	end
# end
i.each do |ins|
	r = Restaurant.find_by(phone: ins.phone)
	r.inspections << ins
	p r
end


# {"CAMIS"=>"40550262", "DBA"=>"MUG SHOTS", "BORO"=>"5", "BUILDING"=>"3785", "STREET"=>"VICTORY BOULEVARD", "ZIPCODE"=>"10314", "PHONE"=>"7188161610", "CUISINECODE"=>"3", "INSPDATE"=>"1/30/13 0:00", "ACTION"=>"D", "VIOLCODE"=>"10F", "SCORE"=>"5", "CURRENTGRADE"=>"A", "GRADEDATE"=>"1/30/13 0:00", "RECORDDATE"=>"01:10.3"}