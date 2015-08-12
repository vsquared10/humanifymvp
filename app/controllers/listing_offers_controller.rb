class ListingOffersController < ApplicationController
  before_action :authenticate_user!

  def create
    @listing = current_user.listing_offers.build(listing_offer_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_path(@listing.id), notice: 'Your offer has been posted.' }
        format.json { render :show, status: :created,
                             location: listing_path(@listing.id) }
      else
        @listing.form_part = "offer"

        format.html { render "listings/new"}
        format.json { render json: @listing.errors, status: :unprocessable_entity }
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
      :duration,
      :tag_list)
  end
end
