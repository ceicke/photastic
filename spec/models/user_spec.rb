require 'spec_helper'

describe User do
  it "should work" do
    u = FactoryGirl.create(:user)
    u.save
    assert_equal true, u.valid?
  end

  it "should not let me pick an e-mail twice" do
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.build(:user, email: u1.email)
    assert_equal false, u2.valid?
  end

  it "should delete all the albums when she is deleted" do
    a = FactoryGirl.create(:album)

    album_size = Album.all.size
    user_size = User.all.size

    album_user = a.user

    album_user.destroy

    assert_equal Album.all.size, (album_size - 1)
    assert_equal User.all.size, (user_size - 1)
  end
end