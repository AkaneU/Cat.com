FactoryBot.define do
  factory :inquiry do
    email { Faker::Internet.email }
    name { Faker::Lorem.characters(number: 10) }
    title { Faker::Lorem.characters(number: 5) }
    text { Faker::Lorem.characters(number:20) }
    association :end_user, factory: :end_user
  end
end