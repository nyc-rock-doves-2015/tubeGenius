FactoryGirl.define do
  factory :video do
    title Faker::Name.title
    description Faker::Lorem.paragraph
    url Faker::Internet.url
    category "Public"
  end
end
