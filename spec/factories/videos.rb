# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    association :album, factory: :album
    association :user, factory: :user
    description Faker::Lorem.words(5)
    video_file { fixture_file_upload(Rails.root.join(*%w[ spec support videos movie.mov ]), 'image/jpeg') }
  end
end
