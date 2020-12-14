include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :picture do
    association :album, factory: :album
    association :user, factory: :user
    description Faker::Lorem.words(number: 5)
    picture_file { fixture_file_upload(Rails.root.join(*%w[ spec support images mona.jpg ]), 'image/jpeg') }
  end
end
