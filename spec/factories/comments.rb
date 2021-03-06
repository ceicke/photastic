FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    association :commentable, factory: :picture
    comment Faker::Lorem.words(number: 10)
  end
end
