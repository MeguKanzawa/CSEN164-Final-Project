# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.delete_all
product = Product.create!(name: 'The C Programming Language',
  description: %{We have improved the exposition of critical features, such as pointers
  , that are central to C programming. We have refined the original examples, and have added
  new examples in several chapters. C wears well as one's experience with it grows. We hope
  that this book will help you learn C and use it well.},
  image: 'cp.png',
  price: 28.00
)

Product.create!(name: 'Programming Ruby 1.9 & 2.0',
  description: %{Ruby is the fastest growing and most exciting dynamic language out there.},
  image: 'ruby.jpg',
  price: 59.95,
)

Product.create(name: 'Ruby on Rails Tutorial',
  description: %{Best-selling author and leading Rails developer Michael Hartl teaches Rail 
  by guiding you through the development of three example applications of increased sophistication, 
  focusing on the fundamental techniques, in web development needed for virtually any kind of application.},
  image: 'rrt.png',
  price: 49.99,
  )


User.destroy_all
user1 = User.create!(email_address: "mk@gmail.com", password: "1234", admin: false)
user2 = User.create!(email_address: "mk2@gmail.com", password: "5678", admin: false)
User.create!(email_address: "admin@gmail.com", password: "admin", admin: true)

Review.destroy_all
product.reviews.create!(
  rating: 5,
  comment: "very insightful! haha",
  user: user1
)

product.reviews.create!(
  rating: 1,
  comment: "not very helpful for my course.",
  user: user2
)

Order.destroy_all
user1.orders.create!(
  name: "mk",
  address: "123 Rails Lane, Cupertino CA",
  email: "mk@gmail.com",
  paytype: "Credit Card" 
)

user2.orders.create!(
  name: "mk2",
  address: "456 Ruby Street, San Jose CA",
  email: "mk2@gmail.com",
  paytype: "Check"
)