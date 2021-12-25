FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 5) }
    text { Faker::Lorem.characters(number:20) }
    association :end_user, factory: :end_user
  end
end