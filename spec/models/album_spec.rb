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

  it "should delete all the pictures when it is deleted" do
    a = FactoryGirl.create(:album_with_pictures)

    album_count = Album.all.size
    pic_count = Picture.all.size

    pictures_in_album = a.pictures.size

    a.destroy

    assert_equal Album.all.size, album_count - 1
    assert_equal Picture.all.size, (pic_count - pictures_in_album)
  end

  it "should delete the memberships as well" do
    a = FactoryGirl.create(:album_with_members)

    members_size = AlbumMember.all.size
    album_members_size = a.album_members.size

    a.destroy

    assert_equal AlbumMember.all.size, (members_size - album_members_size)
  end

  describe "when looking for the thumbnail picture of the album" do

    describe "if we have images" do

      it "should give me the path to the first image if nothing is set" do
        a = FactoryGirl.create(:album_with_pictures)
        assert_equal a.thumb_picture_url, a.pictures.first.picture_file.url(:thumb)
      end

      it "should give me the path to the set image" do
        a = FactoryGirl.create(:album_with_pictures_and_thumb_image)
        assert_equal a.thumb_picture_url, a.picture.picture_file.url(:thumb)
      end
    end

    it "should give me the path to the placeholder image" do
      a = FactoryGirl.create(:album)
      assert_equal a.thumb_picture_url, ActionController::Base.helpers.asset_path('empty_gallery.png')
    end
  end
end
