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
end