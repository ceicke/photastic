require 'spec_helper'
describe AlbumsController do
  login_user

  describe "GET index" do
    it "assigns all albums as @albums" do
      album = FactoryGirl.create(:album, user: @user)
      get :index
      expect(assigns(:albums)).to eq([album])
    end

    it "should not show albums which do not belong to the user" do
      user = FactoryGirl.create(:user)
      album = FactoryGirl.create(:album, user: user)
      get :index
      expect(assigns(:albums)).not_to eq([album])
    end
  end

end
