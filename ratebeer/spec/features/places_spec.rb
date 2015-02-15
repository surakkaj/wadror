require 'rails_helper'

describe "Places" do
	it "if many are returned by the api, it is shown at the page" do
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
			[ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Koljenorsi", id: 2 ) ]

			)

			visit places_path
			fill_in('city', with: 'kumpula')
			click_button "Search"

			expect(page).to have_content "Oljenkorsi"
			expect(page).to have_content "Koljenorsi"
	 end
	 it "Returns a notice if no no places exist" do
			visit places_path
			fill_in('city', with: 'asdasdasd')
			click_button "Search"

			expect(page).to have_content "No locations in asdasdasd"
	 end
end