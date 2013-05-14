FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    association :picture, factory: :picture
    comment Faker::Lorem.words(10)
  end
end
