require 'rails_helper'



describe "Rating" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff"}
	let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
	let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery } 
	let!(:user) { FactoryGirl.create :user }

	before :each do
		sign_in(username:"Pekka", password:"Secret1")
	end

	it "when given, is registrered to the beer and user who is signed in" do
		visit new_rating_path
		select('iso 3', from:'rating[beer_id]')
		fill_in('rating[score]', with:'15')

		expect{
			click_button "Create Rating"
		}.to change{Rating.count}.from(0).to(1)

		expect(user.ratings.count).to eq(1)
		expect(beer1.ratings.count).to eq(1)
		expect(beer1.average_rating).to eq(15.0)
	end
	it "s are listed on users page" do
		FactoryGirl.create :user, username:"Peted"
		sign_in(username:"Peted", password:"Secret1")
		visit new_rating_path
		select('iso 3', from:'rating[beer_id]')
		fill_in('rating[score]', with:'20')
		click_button "Create Rating"

		sign_in(username:"Pekka", password:"Secret1")
		visit new_rating_path
		select('iso 3', from:'rating[beer_id]')
		fill_in('rating[score]', with:'10')
		click_button "Create Rating"

		visit user_path(user)
		expect(page).to have_content '10'
		expect(page).not_to have_content '20'
	end
	it "is deleted from database when clicked on delete link" do
		sign_in(username:"Pekka", password:"Secret1")
		visit new_rating_path
		select('iso 3', from:'rating[beer_id]')
		fill_in('rating[score]', with:'10')
		click_button "Create Rating"
		visit user_path(user)

		expect{
			click_on 'delete'
		}.to change{Rating.count}.by(-1)
	end

end