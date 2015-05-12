FactoryGirl.define do
  factory :video do
    title Faker::Name.title
    description Faker::Lorem.paragraph
    url Faker::Internet.url
    availability "Public"
  end
end
