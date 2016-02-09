require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit restaurants_url
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
	context 'user not signed in' do
 		scenario 'user cannot create a restaurant' do
			visit restaurants_url
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_on 'Create Restaurant'
			expect(page).not_to have_content 'KFC'
			expect(current_path).to eq new_user_session_path
		end

    # scenario 'user cannot edit a restaurant' do
    #
    # end

    context 'deleting restaurants' do
      before do
  	  	kfc = Restaurant.create(name: 'KFC')
  		  review = kfc.reviews.create(thoughts: 'so so')
  		end

      scenario 'User cannot delete restaurants' do
        visit restaurants_url
        expect(page).not_to have_link 'Delete KFC'
      end
    end
	end
	context 'user signed in' do
	  context 'creating restaurants' do
      before do
        user = create :user
        sign_in(user.email, user.password)
      end
      scenario 'prompts user to fill out a form, then displays the new restaurant' do
        add_restaurant('KFC')
        expect(page).to have_content 'KFC'
        expect(current_path).to eq restaurants_path
      end

      scenario 'users can upload a picture for restaurants' do
        click_on 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        attach_file('Image', './spec/fixtures/background.jpg')
        click_on 'Create Restaurant'
        expect(page).to have_css 'img'
      end

      scenario 'users can add the address of restaurants' do
        click_on 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        fill_in 'Street', with: '3674 Torrey View Ct'
        fill_in 'City', with: 'San Diego'
        fill_in 'State', with: 'CA'
        click_on 'Create Restaurant'
        click_on 'KFC'
        expect(page).to have_content 'Address: 3674 Torrey View Ct, San Diego, CA'
      end

      context 'an invalid restaurant' do
		  	scenario 'does not let you submit a name that is too short' do
          add_restaurant('kf')
					expect(page).not_to have_css 'h2', text: 'kf'
					expect(page).to have_content 'error'
				end
			end
  	end

    context 'editing/delting restaurants' do
      before do
        @user = create :user
        @user2 = create :user2
        sign_in(@user.email, @user.password)
        add_restaurant('KFC')
        click_on 'Sign out'
        sign_in(@user2.email, @user2.password)
      end

      scenario "User cannot see other users' edit link" do
        visit restaurants_url
        expect(page).not_to have_link 'Edit KFC'
      end
      # scenario "User cannot edit someone else's restaurants" do
      #   visit restaurants_path
      #   click_on 'Edit KFC'
      #   fill_in 'Name', with: 'Kentucky Fried Chiken'
      #   click_on 'Update Restaurant'
      #   expect(page).to have_content "You cannot edit others' restaurants."
      #   expect(page).not_to have_content 'Kentucky Fried Chiken'
      # end
      # scenario 'let a user edit a restaurant' do
      #   visit restaurants_path
      #   click_on 'Edit KFC'
      #   fill_in 'Name', with: 'Kentucky Fried Chiken'
      #   click_on 'Update Restaurant'
      #   expect(page).to have_content 'Kentucky Fried Chiken'
      #   expect(current_path).to eq restaurants_path
      # end
      scenario "Users cannot see other users' delete link" do
        visit restaurants_url
        expect(page).not_to have_link 'Delete KFC'
      end
      # scenario "User cannot delete someone else's restaurants" do
      #   visit restaurants_url
      #   click_on 'Delete KFC'
      #   expect(page).to have_content 'KFC'
      # end
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
