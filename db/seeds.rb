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
restaurant = Restaurant.find_by(phone:phone: row["PHONE"])
inspection = Inspection.
if restaurant.phone == 
Inspection.create(
	)





end




# {"CAMIS"=>"40550262", "DBA"=>"MUG SHOTS", "BORO"=>"5", "BUILDING"=>"3785", "STREET"=>"VICTORY BOULEVARD", "ZIPCODE"=>"10314", "PHONE"=>"7188161610", "CUISINECODE"=>"3", "INSPDATE"=>"1/30/13 0:00", "ACTION"=>"D", "VIOLCODE"=>"10F", "SCORE"=>"5", "CURRENTGRADE"=>"A", "GRADEDATE"=>"1/30/13 0:00", "RECORDDATE"=>"01:10.3"}