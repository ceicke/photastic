require 'spec_helper'

describe Picture do
  it "should require an album_id" do
    should validate_presence_of :album_id
  end

  it "should work" do
    p = FactoryGirl.create(:picture)
    p.save
    assert_equal true, p.valid?
  end

  it "should give me the guest user nickname if it is set" do
    p = FactoryGirl.create(:picture, user: nil, guest_user: 'Christoph')
    assert_equal 'Christoph', p.uploader_name
  end

  it "should give me the users's name if it is set" do
    p = FactoryGirl.create(:picture)
    u = p.user
    assert_equal u.nickname, p.uploader_name
  end

end
