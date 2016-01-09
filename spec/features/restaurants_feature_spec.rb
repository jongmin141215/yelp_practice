require 'rails_helper'

feature 'restaurants' do 
  context 'no restaurants have been added' do 
    scenario 'should display a prompt to add a restaurant' do 
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'      
    end
  end 
  context 'restaurants have been added' do 
    before do 
      Restaurant.create(name: 'KFC')
    end  
    scenario 'display restaurants' do 
      visit restaurants_url
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end
  context 'creating restaurants' do 
    scenario 'prompts user to fill out a form, then displays the new restaurant' do 
      visit restaurants_url
      click_on 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_on 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq restaurants_path
    end
  end
  context 'viewing restaurants' do 
    let!(:kfc) { Restaurant.create(name: 'KFC') }
    scenario 'lets a user view a restaurant' do 
      visit restaurants_url
      click_on 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq restaurant_path(kfc)
    end 
  end
end
