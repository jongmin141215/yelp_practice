require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(thoughts: 'So so', rating: 3)
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit restaurants_url
    click_link 'Endorse Review'
    expect(page).to have_content '1 endorsement'
  end

  scenario 'updates the review endorsement count' do
    visit restaurants_url
    click_link 'Endorse Review'
    click_link 'Endorse Review'
    expect(page).to have_content '2 endorsements'
  end

  scenario 'displays 0 endorsements when there are no endorsements' do
    visit restaurants_url
    expect(page).to have_content '0 endorsements'
  end

end
