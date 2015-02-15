class PlacesController < ApplicationController
	before_action :set_place, only: [:show, :edit, :update, :destroy]
	def index
	end

	def search
		if params[:city].nil?
			redirect_to places_path, notice: "Enter the city"
		end
		@places = BeermappingApi.places_in(params[:city])
		if @places.empty?
			redirect_to places_path, notice: "No locations in #{params[:city]}"
		else
			render :index
		end

	end

	private

	def set_place
		@place = Place.find(params[:id])
	end
end