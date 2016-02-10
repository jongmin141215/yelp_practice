require 'rails_helper'

feature 'reviewing' do
  before do
    @user = create :user
    sign_in(@user.email, @user.password)
    add_restaurant('KFC')
    @restaurant = Restaurant.find_by(name: 'KFC')
  end

  scenario 'allows users to leave a review using a form' do
    leave_review('So so', 3)
    expect(page).to have_content 'So so'
    expect(current_path).to eq restaurant_path(@restaurant)
  end

  scenario 'Users can only leave one review per restaurant' do
    leave_review('So so', 3)
    leave_review('Good', 1)
    expect(page).to have_content 'You cannot leave multiple reviews for one restaurant'
    visit restaurant_path(@restaurant)
    expect(page).not_to have_content 'Good'
  end

  scenario 'displays average rating for all reviews' do
    leave_review('So so', 3)
    click_on 'Sign out'
    user2 = create :user2
    sign_in(user2.email, user2.password)
    leave_review('Great', 5)
    expect(page).to have_content 'Average rating: ★★★★☆'
  end

  scenario 'displays how long ago the review was created' do
    leave_review('So so', 3)
    expect(page).to have_content 'less than a minute ago'
  end

  scenario 'Users can click "Read Reviews" to read reviews' do
    leave_review('good', 4)
    visit restaurants_url
    click_on 'Read Reviews'
    expect(page).to have_content 'good'
  end

end
