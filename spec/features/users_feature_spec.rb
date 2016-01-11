require 'rails_helper'

feature 'User can sign in and out' do 
	context 'user not signed in and on homepage' do 
		scenario 'should see a "sign in" and "sign up" link"' do 	
			visit root_url
			expect(page).to have_link 'Sign in'
			expect(page).to have_link 'Sign up'
		end
		scenario 'should not see a "sign out" link' do 
			visit root_url
			expect(page).not_to have_link 'Sign out'
		end
	end
	context 'user signed in and on homepage' do 
		before do 
			visit root_url 
			click_link 'Sign up'
			fill_in 'Email', with: 'test@test.com'
			fill_in 'Password', with: 'password'
			fill_in 'Password confirmation', with: 'password'
			click_button 'Sign up'
		end
		scenario 'should see a "sign out" link' do 
			expect(page).to have_link 'Sign out'
		end

		scenario 'should not see a "sign up" and "sign in" link' do 
			expect(page).not_to have_link 'Sign up'
			expect(page).not_to have_link 'Sign in'
		end
	end
end
