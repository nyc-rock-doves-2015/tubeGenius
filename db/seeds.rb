require 'faker'

User.create(name: "admin",
            password: "password")

15.times do
  user = User.create(name: Faker::Internet.user_name,
                     email: Faker::Internet.safe_email,
                     password: Faker::Internet.password)
  10.times do
    user.videos.create(title: Faker::Name.title,
                       description: Faker::Lorem.paragraph,
                       url: "https://www.youtube.com/watch?v=igp9sJkuAnU",
                       availability: "Public")
  end
end
