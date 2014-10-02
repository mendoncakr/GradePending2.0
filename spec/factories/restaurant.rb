FactoryGirl.define do 
	factory :restaurant do 
		name "GRAMERCY TAVERN"
		boro "1"
		building "42"
		street "EAST   20 STREET                                  "
		zipcode "10003"
		cuisine_code  "3"
		latitude 40.731969
		longitude -73.988987
		
		factory :restaurant_with_inspection do 
		  after(:build) {|restaurant| restaurant.inspections << create(:inspection)}	
		end
	end
end
