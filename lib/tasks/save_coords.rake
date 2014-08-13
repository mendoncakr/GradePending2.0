
	task :coords => :environment do 
		Restaurant.where(latitude: nil).find_each(batch_size: 5000) do |r|
			r.save_coords
		end
	end

