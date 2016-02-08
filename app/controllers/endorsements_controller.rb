class EndorsementsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @review.build_endorsement(current_user)
    if @review.save
      render json: { new_endorsement_count: @review.endorsements.count }
    else
      redirect_to restaurants_url
    end
  end
end
