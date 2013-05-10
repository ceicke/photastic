FactoryGirl.define do
  factory :album do
    name Faker::Lorem.words(2)
    association :user, factory: :user
  end
end
