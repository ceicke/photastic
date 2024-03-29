require 'spec_helper'

describe PicturesController do
  login_user

  describe "GET index" do
    it "assigns all pictures to @pictures" do
      album = FactoryGirl.create(:album_with_pictures, user: @user)
      get :index, album_id: album.id
      expect(assigns(:pictures)).not_to eq(nil)
    end

    it "should not show album content which do not belong to the user" do
      user = FactoryGirl.create(:user)
      album = FactoryGirl.create(:album_with_pictures, user: user)
      get :index, album_id: album.id
      expect(assigns(:pictures)).to eq(nil)
      expect(response).to redirect_to(root_path)
    end

    it "should allow guest users to view the album" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      get :index, album_id: album.id
      expect(assigns(:pictures)).not_to eq(nil)
    end

    it "should allow disallow guest users to view the album when they have the wrong passcode" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '1234password'
      cookies[:nickname] = 'Testguest'
      get :index, album_id: album.id
      expect(response).to redirect_to(new_album_passcode_path(album_id: album.id))
    end

    it "should not allow guests to call the add picture form" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      get :new, album_id: album.id
      expect(response).to redirect_to(album_pictures_path(album_id: album.id))
      expect(response).not_to render_template(:new)
    end

    it "should allow guests to call the add picture form when the appropriate flag was set" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password', guests_can_upload: true)
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      get :new, album_id: album.id
      expect(response).to render_template(:new)
    end

    it "should not allow guests to post pictures" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password')
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      picture_params = FactoryGirl.attributes_for(:picture, album: album)
      post :create, album_id: album.id, picture: picture_params
      expect(response).to redirect_to(album_pictures_path(album_id: album.id))
    end

    it "should allow guests to post pictures when the appropriate flag was set" do
      album = FactoryGirl.create(:album, user: @user, passcode: '123password', guests_can_upload: true)
      sign_out :user
      cookies[:album_passcode]  = '123password'
      cookies[:nickname] = 'Testguest'
      picture_params = FactoryGirl.attributes_for(:picture, album: album)
      post :create, album_id: album.id, picture: picture_params
      expect(response).not_to render_template(:new)
      expect(response).to redirect_to(album_pictures_path(album_id: album.id))
    end

  end

end
