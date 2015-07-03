require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.last_name }
    password 'password1'
    password_confirmation 'password1'
    confirmed_at { Time.now }

    trait :banned do
      banned true
    end

    trait :admin do
      admin true
    end

    trait :unconfirmed do
      confirmed_at nil
    end
  end
end
