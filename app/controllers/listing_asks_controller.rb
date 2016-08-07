class ListingAsksController < ApplicationController
  before_action :authenticate_user!

  def create
    @listing = current_user.listing_asks.build(listing_ask_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_path(@listing.id), notice: 'Your ask has been posted.' }
        format.json { render :show, status: :created,
                             location: listing_path(@listing.id) }
      else
        @listing.form_part = "ask"
        format.html { render "listings/new" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def listing_ask_params
    params.require(:listing_ask).permit(
      :title,
      :type,
      :description,
      :image,
      :points,
      :visibility,
      :tag_list)
  end
end
