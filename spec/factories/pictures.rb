# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    association :album, factory: :album
    association :user, factory: :user
    description Faker::Lorem.words(5)
  end
end
