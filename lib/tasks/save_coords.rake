
task :geocode => :environment do 
	Restaurant.all.find_each(batch_size: 5000) do |r|
		r.save_coords
	end
end



task :save_to_text => :environment do 
	filename = File.open(File.join(Rails.root, 'db', 'lat_long.txt') ,'w+')
	file = File.open(filename, 'r+') do |f|
		Restaurant.where.not(latitude: nil).find_each(batch_size: 5000) do |r|
			f.puts "phone:  #{r.phone} latitude: #{r.latitude} longitude: #{r.longitude}"
		end
	end
end

task :fix_names => :environment do 
	r = Restaurant.all.pluck(:name)
	s= []
	s = r.grep(/&amp;/)
	p s
	s.reject &:empty?
	s.each do |re|
		r = Restaurant.find_by(name: re)
		r.fix_name
	end
end

task :save_inspections => :environment do 
	counter = 0
	Inspection.where(restaurant_id: nil).find_each(batch_size: 5000) do |ins|
		p ins.phone
		r = Restaurant.find_by(phone: ins.phone)
		r.inspections << ins
		
		p counter += 1
	end
end

task :save_csv => :environment do 
	CSV.open(File.join(Rails.root, 'db', 'lat_long.csv'), 'wb', :write_headers=> true, :headers=>["id", "name", "address", "latitude", "longitude"]) do |f|
		Restaurant.where.not(latitude: nil).each do |r|
			f << ["#{r.id}", "#{r.name.strip}","#{r.address}","#{r.latitude}", "#{r.longitude}"]
		end
	end
end

task :add_current_grade => :environment do 
	counter = 0
	Restaurant.find_each(batch_size: 5000) do |rest|
		rest.current_grade = rest.grade
		rest.save
		p counter += 1
	end
end

