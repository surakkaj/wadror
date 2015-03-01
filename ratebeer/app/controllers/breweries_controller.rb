class BreweriesController < ApplicationController  
  before_action :ensure_that_signed_in, except: [:show, :index, :nglist]
  before_action :ensure_that_admin, only: [:destroy, :update]
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :skip_if_cached, only:[:index]
  # GET /breweries
  # GET /breweries.json

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?( "brewerylist-#{@order}")
  end
  
  def index
    @breweries = Brewery.all
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired


    case @order
      when 'name' then 
        @active_breweries.sort_by!{ |b| b.name}
        @retired_breweries.sort_by!{ |b| b.name}
      when 'year' then 
        @active_breweries.sort_by!{ |b| b.year}
        @retired_breweries.sort_by!{ |b| b.year}
    end
   

    if session[:orderBr] = nil

      session[:orderBr] = 1
    else
      session[:orderBr] = nil
      @active_breweries.reverse
      @retired_breweries.reverse
    end
    
    render :index
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  def nglist
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    ["brewerylist-name", "brewerylist-year"].each{ |f| expire_fragment(f) }
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brewery }
      else
        format.html { render action: 'new' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update

    ["brewerylist-name", "brewerylist-year"].each{ |f| expire_fragment(f) }
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    ["brewerylist-name", "brewerylist-year"].each{ |f| expire_fragment(f) }
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end



    private

    
end
