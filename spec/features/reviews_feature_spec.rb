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
end
