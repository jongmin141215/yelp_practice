require 'rails_helper'

feature 'endorsing reviews' do
  before do
    @kfc = Restaurant.create(name: 'KFC')
    @kfc.reviews.create(thoughts: 'So so', rating: 3)
    @user = create :user
    @user2 = create :user2
    sign_in(@user.email, @user.password)
    visit restaurant_path(@kfc)
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    click_on 'Endorse Review'
    expect(page).to have_content '1 endorsement'
  end

  scenario 'updates the review endorsement count', js: true do
    click_on 'Endorse Review'
    click_on 'Sign out'
    sign_in(@user2.email, @user2.password)
    visit restaurant_path(@kfc)
    click_on 'Endorse Review'
    visit restaurant_path(@kfc) # need to fix the plural issue and remove this line
    expect(page).to have_content '2 endorsements'
  end

  scenario 'displays 0 endorsements when there are no endorsements' do
    expect(page).to have_content '0 endorsements'
  end

  scenario 'a user can only endorse 1 time per review', js: true do
    click_on 'Endorse Review'
    click_on 'Endorse Review'
    expect(page).not_to have_content '2 endorsements'
    expect(page).to have_content '1 endorsement' # need to fix the plural issue
  end
end
