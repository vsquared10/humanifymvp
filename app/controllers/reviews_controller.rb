class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @review = current_user.reviews.build(review_params)
    #@offer.listing_id = params[:listing_id]
    #binding.pry()
    respond_to do |format|
      if @review.save
        format.html { redirect_to listing_path(@review.listing), notice: "Offer sent to #{@review.listing.user.name}." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { redirect_to listing_path(@review.listing),
                      notice: @review.errors.full_messages.to_sentence }
        format.json { render json: @review.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  private
    def review_params
      params.require(:review).permit(:text, :rating, :recommend)
    end
end

