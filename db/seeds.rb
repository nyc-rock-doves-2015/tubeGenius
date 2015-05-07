# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(name: "mrpants", email: "amihalop:gmail.com", password: "yolo")

video = user.videos.create(title: "Video Number 1, ya hur", description: "this is the description dawg", url: "https://www.youtube.com/watch?v=hR_eQ3EqOvc", category: "funny")
