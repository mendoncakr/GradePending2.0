require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Restaurant, :type => :model do
	let(:restaurant) {FactoryGirl.create :restaurant}
	let(:inspection) {FactoryGirl.create :inspection}
	it { should validate_uniqueness_of :phone }
  it { should have_many(:inspections) }
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
  
  context '#borough'
  
  it "assigns the appropriate borough" do
    restaurant = FactoryGirl.build(:restaurant, boro: "3")
    expect(restaurant.borough).to eq "Brooklyn"
  end

	context '#inspections' 
	it "assigns the correct violation based on the inspection code" do 
		@restaurant = FactoryGirl.build(:restaurant_with_inspection, phone: "9175551234")
    inspection = FactoryGirl.build(:inspection, phone: "99999")
    @restaurant.inspections << inspection
	  @restaurant.inspections.reload	
		expect(@restaurant.last_violations).to eq "Hot food not held at or above 140°F."
	end

end
