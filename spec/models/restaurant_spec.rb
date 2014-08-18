require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Restaurant, :type => :model do
	let(:restaurant) {FactoryGirl.create :restaurant}
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

	context '#Yelp'
	it "retrieves the yelp business id from Yelp search API" do
			# restaurant =  FactoryGirl.build(:restaurant)
			VCR.use_cassette 'model/yelp_search_api' do
				response = restaurant.yelp_biz_id 
				expect(response).to eq("gramercy-tavern-new-york")
			end
		end

		it "returns an excerpt of the top review" do
      VCR.use_cassette 'model/yelp_business_api' do
  			response = restaurant.top_yelp_review
  			expect(response).to eq("Pretty expensive, but worth it. Little bit of an older crowd, but worth it. \n\nI've only eaten in The tavern area with colleagues, so haven't tried the fixed...")
		end
  end

		it "returns the user for the yelp review " do
      VCR.use_cassette 'model/yelp_business_api' do
			 response = restaurant.yelp_review_user
			 expect(response).to eq("John S.")
		  end
    end

		it "returns the url for the owner of the reviews profile picture" do
      VCR.use_cassette 'model/yelp_business_api' do
			 response = restaurant.yelp_review_user_image
			 expect(response).to eq("http://s3-media4.fl.yelpcdn.com/photo/yFUKeS--E8CkErS-1dryoQ/ms.jpg" )
		  end
    end

	end
