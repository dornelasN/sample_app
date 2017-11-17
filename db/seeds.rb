# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  
end

# take the first 6 users 
#seed the database with 50 posts for each of theses users
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { 
    |user| 
    user.microposts.create!(content: content) 
  }
end 

# Seed following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
# user(1) follows each of the users on the following array (2..50)
following.each { |followed| user.follow(followed) }
# each of the users between 3..40 will follow user (1) back
followers.each { |follower| follower.follow(user) }