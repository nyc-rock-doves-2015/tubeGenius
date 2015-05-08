FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "test_user#{n}" }
    password "password"
  end
end