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
		context 'an invalid restaurant' do 
			scenario 'does not let you submit a name that is too short' do 
				visit restaurants_url
				click_on 'Add a restaurant' 
				fill_in 'Name', with: 'kf'
				click_on 'Create Restaurant'
				expect(page).not_to have_css 'h2', text: 'kf'
				expect(page).to have_content 'error'
			end
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
  context 'editing restaurants' do 
    before do 
      Restaurant.create(name: 'KFC') 
    end
    scenario 'let a user edit a restaurant' do 
      visit restaurants_path
      click_on 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chiken'
      click_on 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chiken'
      expect(current_path).to eq restaurants_path
    end 
  end 
  context 'deleting restaurants' do 
    before do
	  	kfc = Restaurant.create(name: 'KFC')
		  review = kfc.reviews.create(thoughts: 'so so')					
		end

    scenario 'removes a restaurant when a user clicks a delete link' do 
      visit restaurants_url
      click_on 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'    
			expect(page).not_to have_content 'so so'
    end
  end
end
