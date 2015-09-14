require 'spec_helper'
describe AlbumsController do
  login_user

  describe "GET index" do
    it "assigns all albums as @albums" do
      album = FactoryGirl.create(:album, user: @user)
      get :index
      expect(assigns(:albums)).to eq([album])
    end
  end

  describe "GET show" do
    it "assigns the requested album as @album" do
      album = FactoryGirl.create(:album)
      get :show, {:id => album.to_param}
      assigns(:album).should eq(album)
    end
  end

  describe "GET new" do
    it "assigns a new album as @album" do
      get :new, {}, valid_session
      assigns(:album).should be_a_new(Album)
    end
  end

  describe "GET edit" do
    it "assigns the requested album as @album" do
      album = FactoryGirl.create(:album)
      get :edit, {:id => album.to_param}, valid_session
      assigns(:album).should eq(album)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Album" do
        expect {
          post :create, {:album => valid_attributes}, valid_session
        }.to change(Album, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        post :create, {:album => valid_attributes}, valid_session
        assigns(:album).should be_a(Album)
        assigns(:album).should be_persisted
      end

      it "redirects to the created album" do
        post :create, {:album => valid_attributes}, valid_session
        response.should redirect_to(Album.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved album as @album" do
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        post :create, {:album => { "name" => "invalid value" }}, valid_session
        assigns(:album).should be_a_new(Album)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        post :create, {:album => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested album" do
        album = FactoryGirl.create(:album)
        # Assuming there are no other albums in the database, this
        # specifies that the Album created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Album.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => album.to_param, :album => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested album as @album" do
        album = FactoryGirl.create(:album)
        put :update, {:id => album.to_param, :album => valid_attributes}, valid_session
        assigns(:album).should eq(album)
      end

      it "redirects to the album" do
        album = FactoryGirl.create(:album)
        put :update, {:id => album.to_param, :album => valid_attributes}, valid_session
        response.should redirect_to(album)
      end
    end

    describe "with invalid params" do
      it "assigns the album as @album" do
        album = FactoryGirl.create(:album)
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        put :update, {:id => album.to_param, :album => { "name" => "invalid value" }}, valid_session
        assigns(:album).should eq(album)
      end

      it "re-renders the 'edit' template" do
        album = FactoryGirl.create(:album)
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        put :update, {:id => album.to_param, :album => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested album" do
      album = FactoryGirl.create(:album)
      expect {
        delete :destroy, {:id => album.to_param}, valid_session
      }.to change(Album, :count).by(-1)
    end

    it "redirects to the albums list" do
      album = FactoryGirl.create(:album)
      delete :destroy, {:id => album.to_param}, valid_session
      response.should redirect_to(albums_url)
    end
  end

end
