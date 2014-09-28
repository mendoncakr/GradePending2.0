require 'rails_helper'

feature "Restaurant Search" do 
	scenario "User searches for a single restaurant" do 
		visit "/"
		fill_in "search", :with => "Gramercy Tavern"
		click_button "Search"
		expect(page).to have_text("Gramercy Tavern") 
	end

	scenario "User searches for multiple restaurants" do 
		visit "/"
		fill_in "search", :with => "Subway"
		click_button "Search"
		expect(page).to have_content("Search Results:")
	end
end