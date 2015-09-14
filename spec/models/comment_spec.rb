require 'spec_helper'

describe Comment do
  it "should require a commentable object" do
    c = FactoryGirl.build(:comment, commentable_id: nil)
    assert_equal false, c.valid?
  end

  it "should require a comment" do
    c = FactoryGirl.build(:comment, comment: nil)
    assert_equal false, c.valid?
  end

  it "should work" do
    c = FactoryGirl.create(:comment)
    c.save
    assert_equal true, c.valid?
  end

  it "should require a user_id or a nickname" do
    c = FactoryGirl.build(:comment, user_id: nil, nickname: nil)
    assert_equal false, c.valid?

    c.user = FactoryGirl.create(:user)
    assert_equal true, c.valid?

    c.user = nil
    c.nickname = 'Nifty User'
    assert_equal true, c.valid?
  end
end
