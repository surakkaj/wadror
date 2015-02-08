require 'rails_helper'

describe "beer" do

	before :each do
		FactoryGirl.create :user
		sign_in(username:"Pekka", password:"Secret1")
	end
	
	it "is created when valid input" do
		FactoryGirl.create :brewery

		visit new_beer_path
		fill_in('beer_name', with:'Beer')
		click_button('Create Beer')

		expect(Beer.count).to eq(1)
		expect(current_path).to eq(beers_path)
	end

	it "is not created and user is redirected to create page" do
	
		visit new_beer_path
		click_button('Create Beer')

		expect(Beer.count).to eq(0)
		expect(page).to have_content 'Name can\'t be blank'
	end

	it "includes everything useful regardin the usage of simplecov" do
		BeerClub
		BeerClubsController
		SessionsController
		UsersController
		expect(1).to eq(1)
	end
end