module AppHelpers
  def sign_in(email, password)
    visit new_user_session_url
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

  def add_restaurant(name)
    click_on 'Add a restaurant'
    fill_in 'Name', with: name
    click_on 'Create Restaurant'
  end

  def leave_review(thoughts, rating)
    visit restaurants_url
    click_on 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_on 'Leave Review'
  end
end
