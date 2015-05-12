FactoryGirl.define do
  factory :video do
    user_id 1
    title Faker::Name.title
    description Faker::Lorem.paragraph
    url Faker::Internet.url
    availability "Public"
  end
end
