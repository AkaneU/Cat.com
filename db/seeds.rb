# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin',
  password: 'adminadmin',
)

5.times do |n|
  EndUser.create!(
    email: "test#{n + 1}@test.com",
    name: "テストユーザー#{n + 1}",
    password: "testtest"
  )
end

EndUser.all.each do |end_user|
  end_user.inquiries.create!(
    name: 'テスト',
    email: 'test@test.com',
    title: 'タイトル',
    text: 'テキストテキストテキストテキスト'
  )
end