FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :user2, class: User do
    email 'test2@test.com'
    password 'password'
    password_confirmation 'password'
  end
end
