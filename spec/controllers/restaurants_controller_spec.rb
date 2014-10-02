require 'rails_helper'

RSpec.describe RestaurantsController, :type => :controller do 
  describe "GET index" do 
    it "renders the index template" do 
      get :index
      expect(response).to render_template("index")
    end
    
    it "returns JSON" do 
      get :index, format: :json 
      expect(response.content_type).to eq('application/json')
    end
    
    it "returns JSON containing Restaurant names and IDs" do 
      get :index, format: :json
      parsed_content = JSON.parse(response.body)
      expect(parsed_content["WILD ASIA"]).to eq(2)
    end 
  end

  describe "GET statistics" do 
    it "renders the statistics template" do 
      get :statistics
      expect(response).to render_template("statistics")
    end
  end

  describe "POST search" do 
    it "redirects to the restaurant show page when passed in a single restaurant" do 
      post :search, "search" => "gramercy tavern"
      expect(response).to have_http_status(302)
    end
  end
end
