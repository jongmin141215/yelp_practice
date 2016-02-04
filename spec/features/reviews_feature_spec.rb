require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create(name: 'KFC') }

  scenario 'allows users to leave a review using a form' do
    visit restaurants_url
    click_on 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_on 'Leave Review'

    expect(page).to have_content 'so so'
    expect(current_path).to eq restaurants_path
  end

  scenario 'Users can only leave one review per restaurant' do
    user = create :user
    sign_in(user.email, user.password)
    add_restaurant('KFC')
    leave_review('So so', 3)
    leave_review('Good', 1)
    expect(page).to have_content 'You cannot leave multiple reviews for one restaurant'
    visit restaurants_url
    expect(page).not_to have_content 'Good'
  end

  scenario 'displays average rating for all reviews' do
    user = create :user
    sign_in(user.email, user.password)
    leave_review('So so', 3)
    click_on 'Sign out'
    user2 = create :user2
    sign_in(user2.email, user2.password)
    leave_review('Great', 5)
    expect(page).to have_content 'Average rating: ★★★★☆'
  end

  scenario 'displays how long ago the review was created' do
    user = create :user
    sign_in(user.email, user.password)
    leave_review('So so', 3)
    expect(page).to have_content 'less than a minute ago'
  end


end
