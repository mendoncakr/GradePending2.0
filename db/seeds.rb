require 'csv'
# file = File.expand_path('../../public/WebExtract2.csv', __FILE__)
# CSV.parse(File.open(file, 'r:iso-8859-1:utf-8'){|f| f.read}, col_sep: ',', headers: true) do |row|
# 	row = row.to_hash

# 	r = Restaurant.create(
# 		name: row["DBA"],
# 		boro: row["BORO"],
# 		building: row["BUILDING"],
# 		street: row["STREET"],
# 		zipcode: row["ZIPCODE"],
# 		phone: row["PHONE"],
# 		cuisine_code: row["CUISINECODE"]
# 		)



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
# end
 																												

# Add inspections to their respective restaurants
counter = 0
Inspection.where(restaurant_id: nil).find_each(batch_size: 5000) do |ins|
	p ins.phone
	r = Restaurant.find_by(phone: ins.phone)
	r.inspections << ins
	p counter
	counter += 1
end

#Write coords to new file 

# filename = File.open(File.join(Rails.root, 'db', 'coords.csv'))
# file = File.open(filename, 'r+') do |f|
# 	Restaurant.where.not(latitude: nil).each do |r|
# 		f.puts "phone:  #{r.phone} latitude: #{r.latitude} longitude: #{r.longitude}"
# 	end
# end


# ADD Coordinates to DB:

# filename = File.open(File.join(Rails.root, 'db', 'lat_long.csv'))
# filename.each do |row|
# 	p row.split[1]
# 	p rest = Restaurant.find_by(phone: row.split[1])

# 	if rest.phone == nil
# 		puts "*"*100
# 	else
# 		p rest.id
# 		rest.update(latitude: row.split[3], longitude: row.split[5])
# 	end
# end




# {"CAMIS"=>"40550262", "DBA"=>"MUG SHOTS", "BORO"=>"5", "BUILDING"=>"3785", "STREET"=>"VICTORY BOULEVARD", "ZIPCODE"=>"10314", "PHONE"=>"7188161610", "CUISINECODE"=>"3", "INSPDATE"=>"1/30/13 0:00", "ACTION"=>"D", "VIOLCODE"=>"10F", "SCORE"=>"5", "CURRENTGRADE"=>"A", "GRADEDATE"=>"1/30/13 0:00", "RECORDDATE"=>"01:10.3"}