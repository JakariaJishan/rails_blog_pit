# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# user = User.create(name:"jack")
# user2= User.create(name:"joe")
#
# post1 = Post.create(title:"post1", content:"this is post1", user_id: user.id)
# post2 = Post.create(title:"post2", content:"this is post2", user_id: user.id)
#
# Comment.create(body:"this comment is for post 1", user_id:user.id, post:post1)
# Comment.create(body:"this comment is for post 2", user_id:user2.id, post:post2)

Badge.create(name: "Contributor", description: "Awarded for creating 10 posts")
Badge.create(name: "First Post", description: "Awarded for creating your first post")
Badge.create(name: "Active Contributor", description: "Awarded for creating 50 posts")
Badge.create(name: "Helpful", description: "Awarded for getting 10 likes on an answer")
