FactoryBot.define do
  factory :end_user do
    email { Faker::Internet.email }
    name { Faker::Lorem.characters(number: 10) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end