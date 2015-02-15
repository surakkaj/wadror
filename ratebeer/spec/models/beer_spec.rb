require 'rails_helper'

RSpec.describe Beer, type: :model do
	FactoryGirl.create :style
	it "is saved correctly when has name nad style" do
		beer = Beer.create name:"Test", style_id: 1
		expect(beer).to be_valid
	end

	it "is not saved without a name" do
		beer = Beer.create style_id:1
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
			expect(beer.style_id).to eq(1)
	end
end


end
