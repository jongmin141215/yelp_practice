class RestaurantsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :update, :destroy]
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.build_with_user(restaurant_params, current_user)
    if @restaurant.save
			redirect_to restaurants_url
    else
			render 'new'
    end
  end
  def show
    @restaurant = Restaurant.find(params[:id])
  end
  def edit
    @restaurant = Restaurant.find(params[:id])
  end
  def update
    @restaurant = Restaurant.find(params[:id])
		if current_user && current_user.id == @restaurant.user_id
			@restaurant.update(restaurant_params)
			redirect_to restaurants_url
		else
			flash.now[:notice] = "You cannot edit others' restaurants."
			render 'edit'
		end

  end
  def destroy
		@restaurant = Restaurant.find(params[:id])
		if current_user && current_user.id == @restaurant.user_id
			@restaurant.destroy
	    flash[:notice] = 'Restaurant deleted successfully'
	    redirect_to restaurants_url
		else
			flash[:notice] = "You cannot delete other's restaurants."
			redirect_to restaurants_url
		end
  end
  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :image, :street, :city, :state)
  end
end
