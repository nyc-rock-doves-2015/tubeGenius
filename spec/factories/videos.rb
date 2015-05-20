FactoryGirl.define do
  factory :video do
    user_id 1
    title "Test Video"
    description Faker::Lorem.paragraph
    url "https://www.youtube.com/watch?v=YDXVAvqj6vU"
    availability "Public"
  end
end
