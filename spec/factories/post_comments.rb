FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 100) }
    association :end_user, factory: :end_user
    association :post, factory: :post
  end
end