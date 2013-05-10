FactoryGirl.define do

  sequence :email do
    id = User.all.size
    "foo#{id}@example.com"
  end

  factory :user, class: User do
    email
    password "foobar123"
    password_confirmation "foobar123"
  end

end
