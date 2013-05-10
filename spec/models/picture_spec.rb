require 'spec_helper'

describe Picture do
  it "should require an album_id" do
    should validate_presence_of :album_id
  end

  it "should require a user" do
    should validate_presence_of :user_id
  end

  it "should work" do
    p = FactoryGirl.create(:picture)
    p.save
    assert_equal true, p.valid?
  end
end
