FactoryGirl.define do
  factory :album do
    name Faker::Lorem.words(2)
    guests_can_upload false
    association :user, factory: :user
  end

  factory :album_with_pictures, class: Album do
    name Faker::Lorem.words(2)
    guests_can_upload false
    association :user, factory: :user

    after(:create) do |album|
      5.times do
        FactoryGirl.create(:picture, album_id: album.id, user_id: album.user.id)
      end
    end
  end

  factory :album_with_videos, class: Album do
    name Faker::Lorem.words(2)
    guests_can_upload false
    association :user, factory: :user

    after(:create) do |album|
      5.times do
        FactoryGirl.create(:video, album_id: album.id, user_id: album.user.id)
      end
    end
  end

  factory :album_with_pictures_and_thumb_image, class: Album do
    name Faker::Lorem.words(2)
    guests_can_upload false
    association :user, factory: :user

    after(:create) do |album|
      5.times do
        FactoryGirl.create(:picture, album_id: album.id)
      end
      album.update_attributes(picture_id: album.pictures.last.id)
    end
  end

  factory :album_with_members, class: Album do
    name Faker::Lorem.words(2)
    guests_can_upload false
    association :user, factory: :user

    after(:create) do |album|
      4.times do
        FactoryGirl.create(:album_member, album_id: album.id)
      end
    end
  end
end
