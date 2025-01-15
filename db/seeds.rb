require 'faker'

# Users
puts 'Seeding users...'
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 111111,
    username: Faker::Internet.unique.username,
    date: Faker::Date.birthday(min_age: 18, max_age: 65),
    phone_number: Faker::PhoneNumber.cell_phone,
    online: [true, false].sample,
    last_seen_at: Faker::Time.backward(days: 7),
    banned: false,
    isAdmin: false
  )
end

u = User.create!(
    email: 'admin@gmail.com',
    password: 111111,
    username: "admin",
    date: Faker::Date.birthday(min_age: 18, max_age: 65),
    phone_number: Faker::PhoneNumber.cell_phone,
    online: [true, false].sample,
    last_seen_at: Faker::Time.backward(days: 7),
    banned: false,
    isAdmin: true
  )

u.skip_confirmation!
u.save!

# Badges
puts 'Seeding badges...'
5.times do
  Badge.create!(
    name: Faker::Superhero.unique.name,
    description: Faker::Lorem.sentence
  )
end

# Posts
puts 'Seeding posts...'
users = User.all
10.times do
  Post.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph,
    user: users.sample,
    banned: [true, false].sample
  )
end

# Questions
puts 'Seeding questions...'
10.times do
  Question.create!(
    title: Faker::Lorem.question,
    content: Faker::Lorem.paragraph,
    user: users.sample
  )
end

# Answers
puts 'Seeding answers...'
questions = Question.all
20.times do
  Answer.create!(
    content: Faker::Lorem.paragraph,
    user: users.sample,
    question: questions.sample
  )
end

# Comments
puts 'Seeding comments...'
posts = Post.all
20.times do
  Comment.create!(
    body: Faker::Lorem.sentence,
    user: users.sample,
    post: posts.sample,
    parent_id: nil # Adjust for nested comments if needed
  )
end

# Likes
puts 'Seeding likes...'
20.times do
  Like.create!(
    user: users.sample,
    post: posts.sample,
    likes_type: %w[upvote downvote].sample
  )
end

# Notifications
puts 'Seeding notifications...'
20.times do
  Notification.create!(
    user: users.sample,
    message: Faker::Lorem.sentence,
    read: [true, false].sample
  )
end

# Reels
puts 'Seeding reels...'
10.times do
  Reel.create!(
    title: Faker::Movie.title,
    description: Faker::Lorem.sentence,
    user: users.sample
  )
end


# User Badges
puts 'Seeding user badges...'
badges = Badge.all
20.times do
  UserBadge.create!(
    user: users.sample,
    badge: badges.sample
  )
end

puts 'Seeding completed!'
