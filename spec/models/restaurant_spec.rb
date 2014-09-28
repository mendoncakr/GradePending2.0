require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Restaurant, :type => :model do
	let(:restaurant) {FactoryGirl.create :restaurant}
	let(:inspection) {FactoryGirl.create :inspection}
	it { should validate_uniqueness_of :phone }
	it "creates a valid restaurant" do 
		expect(restaurant).to be_valid
	end

	context '#address'

	it "removes trailing whitespace" do 
		@restaurant = FactoryGirl.build(:restaurant)
		expect(@restaurant.address).to eq "42 EAST   20 STREET Manhattan 10003"
	end

	context '#name'

	it "replaces &amp;" do 
		restaurant = FactoryGirl.build(:restaurant, name: "Joe's Pizza &amp; Shakes")
		restaurant.fix_name
		new_restaurant = restaurant
		expect(new_restaurant.name).to eq "Joe's Pizza & Shakes"
	end

	context '#inspections' 
	it "assigns the correct violation based on the inspection code" do 
		@restaurant = FactoryGirl.build(:restaurant_with_inspection)
		
		expect(@restaurant.last_violations.first).to eq "Hot food not held at or above 140°F."
	end

end
