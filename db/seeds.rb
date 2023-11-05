# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# clears database

User.destroy_all
Friendship.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')

password = "godofThunder"
10.times do |i|
    User.create(username: "testsubject#{i}", email: "test#{i}@gmail.com", password: "godofThunder#{i}", password_confirmation: "godofThunder#{i}")
end