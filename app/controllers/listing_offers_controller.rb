class ListingOffersController < ApplicationController
  before_action :authenticate_user!

  def create
    @listing_offer = current_user.listing_offers.build(listing_offer_params)

    respond_to do |format|
      if @listing_offer.save
        format.html { redirect_to listing_path(@listing_offer.id), notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created,
                             location: listing_path(@listing_offer.id) }
      else
        format.html { render :new }
        format.json { render json: @listing_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def listing_offer_params
    params.require(:listing_offer).permit(
      :title,
      :type,
      :description,
      :image,
      :points,
      :visibility,
      :tag_list)
  end
end
