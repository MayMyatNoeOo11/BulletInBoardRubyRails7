# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
10.times do
    User.create!(
        name:Faker::Name.first_name ,
        email:Faker::Internet.email,
        password_digest:BCrypt::Password.create('12345678'),
        phone:"09798939139",
        user_type:"1",
        address:Faker::Address.full_address,
        date_of_birth:Faker::Date.between(from: '1980-09-23', to: '2000-09-25'),
        profile_photo:"C:/photo",
        created_user_id:1,
        updated_user_id:1
    )
  end
#create 10 posts
10.times do
    Post.create!(
        title: Faker::Game.title,
        description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),        
        status: 1,
        created_user_id: 1,
        updated_user_id:1,
        deleted_user_id: 0,
        user_id: 1
    )
  end