class EndorsementsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    redirect_to restaurants_url
  end
end
