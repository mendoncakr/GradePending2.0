
	task :coords => :environment do 
		Restaurant.where(latitude: nil).find_each(batch_size: 5000) do |r|
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
