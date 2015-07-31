class OffersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_offer, on: :update

  def create
    @offer = current_user.offers.build(offer_params)
    #@offer.listing_id = params[:listing_id]

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer.listing, notice: 'Offer sent.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { redirect_to @offer.listing,
                      notice: @offer.errors.full_messages.to_sentence }
        format.json { render json: @offer.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if status_param[:status] == "Accept"
        @offer.accept
      elsif status_param[:status] == "Decline"
        @offer.decline
      end

      if @offer.save
        format.html { redirect_to @offer.listing,
                      notice: "Offer #{@offer.status}." }
        format.json { render :show, status: :ok, location: @offer}
      else
        format.html { redirect_to @offer.listing,
                      notice: @offer.errors.full_messages.to_sentence}
        format.json { render json: @offer.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:listing_id,:points,:status,:reversed)
    end

    def status_param
      params.permit(:status)
    end
end
