# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album_member do
    association :user, factory: :user
    association :album, factory: :album
    can_administer { false }
    can_addphotos { false }
  end
end
