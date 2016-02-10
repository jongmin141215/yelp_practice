class ReviewsController < ApplicationController
	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end
	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = @restaurant.reviews.build_with_user(review_params, current_user)
		if @review.save
			redirect_to restaurant_path(@restaurant)
		else
			flash[:notice] = 'You cannot leave multiple reviews for one restaurant'
			render 'new'
		end
	end
	private
	def review_params
 		params.require(:review).permit(:thoughts, :rating)
	end
end
