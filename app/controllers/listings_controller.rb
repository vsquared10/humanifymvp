class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /listings
  # GET /listings.json
  def index
    if user_signed_in?
      @listings = Listing.where(
        ["location = :location or visibility = :visibility",{
        location: current_user.zip_code.to_s.to_region(city: true),
        visibility: "global" }]).where(status: "pending")
    else
      @listings = Listing.open_global
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = current_user.listings.build
  end
  
  # POST /listings
  # POST /listings.json
  def create
    @listing = current_user.listings.build(listing_param)
    @listing.form_part = @listing.listing_offer
    render 'new'
  end
  # GET /listings/1/edit
  def edit
    @listing.form_part = @listing.listing_offer
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    unless @listing.tag_list == listing_params[:tag_list].split(",")
      @listing.tag_list = listing_params[:tag_list]
      @listing.save
    end
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Your listing has been updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to profile_path, notice: "Your listing for #{@listing.title} has been deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def correct_user
      @listing = current_user.listings.find_by(id: params[:id])
      redirect_to listings_path, notice: "You don't have permission to edit this listing." if @listing.nil?
    end

    def listing_param
      params.require(:listing).permit(:type)
    end
end
