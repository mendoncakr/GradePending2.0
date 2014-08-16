require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
 let(:restaurant) {FactoryGirl.create :restaurant}

	it "creates a valid restaurant" do 
		expect(restaurant).to be_valid
	end

	context '#address'

		it "removes trailing whitespace" do 
			@restaurant = FactoryGirl.build(:restaurant)
			expect(@restaurant.address).to eq "42 EAST   20 STREET   10003"
		end

	context '#name'

		it "replaces &amp;" do 
			@restaurant = FactoryGirl.build(:restaurant, name: "Joe's Pizza &amp; Shakes")
			expect (@restaurant.fix_name).to eq "Joe's Pizza & Shakes"
		end


end
