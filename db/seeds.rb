# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Starting new seed ..."
1223.times do |i|
  User.create(email: "flat#{i}@flat.com",
              password: "123123",
              first_name: "Flat#{i}",
              last_name: "Flat#{i}x",
              nickname: "flat_#{i}",
              description: "flat_earther_#{i}",
              converted: "true")
  puts "created #{i} users"
end
