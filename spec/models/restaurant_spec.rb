require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
 let(:restaurant) {FactoryGirl.create :restaurant}

	it "creates a valid restaurant" do 
		expect(restaurant).to be_valid
	end
end
