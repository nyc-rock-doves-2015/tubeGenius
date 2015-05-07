FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_user#{n}@fakeemail.com" }
    password "password"
  end
end