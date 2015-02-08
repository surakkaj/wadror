require 'rails_helper'

describe "Breweries page" do
	it "should not have any before been created" do
	visit breweries_path
	expect(page).to have_content 'Listing breweries'
	expect(page).to have_content 'Number of breweries: 0'
	end	
	describe "when breweries exist" do
		before :each do
		@breweries = ["Koof", "kariala", "scherlenko"]
		year = 1896
		@breweries.each do |b|
			FactoryGirl.create(:brewery, name:b, year: year += 1)
		end
		visit breweries_path
	end
	it "lists the existing breweries and their total numbers" do
		
		expect(page).to have_content "Number of breweries: #{@breweries.count}"
		@breweries.each do |b|
			expect(page).to have_content b
		end
	end

	it "allows user to navigate to page of a Brewery" do
		
		click_link "Koof"

		expect(page).to have_content "Koof"
		expect(page).to have_content "Established in 1897"
	end
end
end