require 'rails_helper'

feature 'reviewing' do
  # before { Restaurant.create(name: 'KFC') }
  #
  # scenario 'allows users to leave a review using a form' do
  #   visit restaurants_url
  #   click_on 'Review KFC'
  #   fill_in 'Thoughts', with: 'so so'
  #   select '3', from: 'Rating'
  #   click_on 'Leave Review'
  #
  #   expect(page).to have_content 'so so'
  #   expect(current_path).to eq restaurants_path
  # end

  scenario 'Users can only leave one review per restaurant' do
    user = create :user
    sign_in(user.email, user.password)
    add_restaurant('KFC')
    visit restaurants_url
    click_on 'Review KFC'
    fill_in 'Thoughts', with: 'So so'
    select '3', from: 'Rating'
    click_on 'Leave Review'
    click_on 'Review KFC'
    fill_in 'Thoughts', with: 'hi'
    select '3', from: 'Rating'
    click_on 'Leave Review'
    expect(page).to have_content 'You cannot leave multiple reviews for one restaurant'
    visit restaurants_url
    expect(page).not_to have_content 'hi'
  end
end
