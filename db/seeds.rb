require 'faker'
require 'open-uri'

# Users
puts 'Seeding users...'

user = User.new(
    email: "admin@example.com",
    password: "111111",  # Using a strong default password
    username: Faker::Internet.username(specifier: 5..8),
    date: Faker::Date.birthday(min_age: 18, max_age: 65),
    phone_number: Faker::PhoneNumber.cell_phone,
    online: [true, false].sample,
    last_seen_at: Faker::Time.backward(days: 7),
    banned: false,
    isAdmin: true
  )

  # Attaching a random avatar
  user.avatar.attach(
    io: URI.open("https://picsum.photos/300/300?random=#{rand(1..1000)}"),
    filename: "avatar#{1}.jpg",
    content_type: 'image/jpeg'
  )

  user.skip_confirmation!  # Skipping email confirmation (if Devise is used)
  user.save


20.times do |i|
  user = User.new(
    email: "user#{i + 1}@example.com",
    password: "111111",  # Using a strong default password
    username: Faker::Internet.username(specifier: 5..8),
    date: Faker::Date.birthday(min_age: 18, max_age: 65),
    phone_number: Faker::PhoneNumber.cell_phone,
    online: [true, false].sample,
    last_seen_at: Faker::Time.backward(days: 7),
    banned: false,
    isAdmin: false
  )

  # Attaching a random avatar
  user.avatar.attach(
    io: URI.open("https://picsum.photos/300/300?random=#{rand(1..1000)}"),
    filename: "avatar#{i}.jpg",
    content_type: 'image/jpeg'
  )

  user.skip_confirmation!  # Skipping email confirmation (if Devise is used)
  user.save
end
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

30.times do |i|
  p = Post.new(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph,
      user: users.sample,
      banned: false
    )

p.post_images.attach(
  io: URI.open("https://picsum.photos/300/300?random=#{rand(1..100)}"),
  filename: "image#{i + 1}.jpg",
  content_type: 'image/jpeg'
)
p.save
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


#stories
puts 'Seeding stories...'
20.times do
 s = Story.new(
 user: users.sample
 )

  s.image.attach(
    io: URI.open("https://picsum.photos/300/300?random=#{rand(1..1000)}"),
    filename: "story#{rand(1..1000)}.jpg",
    content_type: 'image/jpeg'
  )
  s.save
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
