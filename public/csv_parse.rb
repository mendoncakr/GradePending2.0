require 'csv'
require 'chronic'


file = File.expand_path('../../public/WebExtract3.csv', __FILE__)
CSV.parse(File.open(file, 'r:iso-8859-1:utf-8'){|f| f.read}, col_sep: ',', headers: true) do |row|
	CSV.open('new_csv.csv', 'w') do |f|
		if Chronic.parse(row["INSPDATE"]) >= Chronic.parse("January 1, 2014")
			f << ["What the he'll is this"]
		end
	end
end

