require 'spec_helper'

describe PicturesController do
  login_user

  describe "GET index" do
    it "assigns all albums as @albums" do
      album = FactoryGirl.create(:album_with_pictures, user: @user)
      get :index, album_id: album.id
      expect(assigns(:pictures)).not_to eq(nil)
    end

    it "should not show albums which do not belong to the user" do
      user = FactoryGirl.create(:user)
      album = FactoryGirl.create(:album_with_pictures, user: user)
      get :index, album_id: album.id
      expect(assigns(:pictures)).to eq(nil)
      expect(response).to redirect_to(root_path)
    end
  end

end
