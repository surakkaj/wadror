require 'rails_helper'

RSpec.describe Beer, type: :model do
	it "is saved correctly when has name nad style" do
		beer = Beer.create name:"Test", style:"Lager"
		expect(beer).to be_valid
	end

	it "is not saved without a name" do
		beer = Beer.create style:"Lager"
		expect(beer).not_to be_valid
	end

	it "is not saved without a style" do
		beer = Beer.create name:"Test"
		expect(beer).not_to be_valid
	end

	describe "when one beer exists" do
		let(:beer){FactoryGirl.create(:beer)}
		it "is valid" do
			expect(beer).to be_valid
		end
		it "has the default style" do
			expect(beer.style).to eq("Lager")
	end
end


end
