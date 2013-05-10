require 'spec_helper'

describe Album do
  it "should require a name" do
    should validate_presence_of :name
  end

  it "should require a user" do
    should validate_presence_of :user_id
  end

  it "should work" do
    a = FactoryGirl.create(:album)
    a.save
    assert_equal true, a.valid?
  end
end
