FactoryGirl.define do
  factory :album do
    name Faker::Lorem.words(2)
    association :user, factory: :user
  end

  factory :album_with_pictures, class: Album do
    name Faker::Lorem.words(2)
    association :user, factory: :user

    after(:create) do |album|
      5.times do
        FactoryGirl.create(:picture, album_id: album.id)
      end
    end
  end

  factory :album_with_pictures_and_thumb_image, class: Album do
    name Faker::Lorem.words(2)
    association :user, factory: :user

    after(:create) do |album|
      5.times do
        FactoryGirl.create(:picture, album_id: album.id)
      end
      album.update_attributes(picture_id: album.pictures.last.id)
    end
  end
end
