require 'spec_helper'

describe VideosController do
  login_user

  describe "GET index" do
    it "assigns all videos to @videos" do
      album = FactoryGirl.create(:album_with_videos, user: @user)
      get :index, album_id: album.id
      expect(assigns(:videos)).not_to eq(nil)
    end

    it "should not show album content which do not belong to the user" do
      user = FactoryGirl.create(:user)
      album = FactoryGirl.create(:album_with_videos, user: user)
      get :index, album_id: album.id
      expect(assigns(:videos)).to eq(nil)
      expect(response).to redirect_to(root_path)
    end

    it "should allow guest users to view the album" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      get :index, album_id: album.id
      expect(assigns(:videos)).not_to eq(nil)
    end

    it "should allow disallow guest users to view the album when they have the wrong passcode" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '1234password'
      cookies[:nickname] = 'Testguest'
      get :index, album_id: album.id
      expect(response).to redirect_to(new_album_passcode_path(album_id: album.id))
    end

    it "should not allow guests to call the add video form" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      get :new, album_id: album.id
      expect(response).to redirect_to(album_videos_path(album_id: album.id))
      expect(response).not_to render_template(:new)
    end

    it "should allow guests to call the add video form when the appropriate flag was set" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password', guests_can_upload: true)
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      get :new, album_id: album.id
      expect(response).to render_template(:new)
    end

    it "should not allow guests to post videos" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      video_params = FactoryGirl.attributes_for(:video, album: album)
      post :create, album_id: album.id, video: video_params
      expect(response).to redirect_to(album_videos_path(album_id: album.id))
    end

    it "should allow guests to post videos when the appropriate flag was set" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password', guests_can_upload: true)
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      video_params = FactoryGirl.attributes_for(:video, album: album)
      post :create, album_id: album.id, video: video_params
      expect(response).not_to render_template(:new)
      expect(response).to redirect_to(album_videos_path(album_id: album.id))
    end
  end

end
