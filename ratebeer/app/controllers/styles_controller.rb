class StylesController < ApplicationController
	before_action :ensure_that_admin, only: [:destroy, :update]
	def index
		@styles = Style.all
	end

	def new
		@style = style.new
		@beers = Beer.all
	end

	def show
		@style = Style.find(params[:id])
  	end

	
end