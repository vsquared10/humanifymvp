class OffersController < ApplicationController
  def create
    @offer = current_user.offers.build(
      params.require(:offer).permit(:points)
    )
    @offer.listing_id = params[:id]

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer.listing, notice: 'Offer sent.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end
end
