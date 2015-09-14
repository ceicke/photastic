require 'spec_helper'

describe Video do

  after(:all) do
    current_dir = Dir.pwd
    FileUtils.rm_rf(current_dir + '/app/shared/')
  end

  it "should require an album_id" do
    should validate_presence_of :album_id
  end

  it "should require a user" do
    should validate_presence_of :user_id
  end

  it "should work" do
    v = FactoryGirl.create(:video)
    v.save
    assert_equal true, v.valid?
  end

  describe "should work with heywatch to encode videos" do

    it "and create a directory for the video to be uploaded to" do
      v = FactoryGirl.create(:video)
      v.save
      File.directory?("#{Rails.root}/app/shared/public/system/videos_encoded/#{v.album.id}/#{v.id}")
    end

    it "should not be marked as encoded" do
      v = FactoryGirl.create(:video)
      v.save
      v.encoded.should == false
    end

  end
end
