class AlbumsController < ApplicationController

  skip_before_filter :authenticate_user!, only: :show
  load_and_authorize_resource

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.where(user_id: current_user.id)

    Member.where(user_id: current_user.id).each do |membership|
      unless membership.album.blank?
        @albums << membership.album
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  def show
    album = Album.find(params[:id])

    respond_to do |format|
      format.html { redirect_to album_pictures_path(album) }
      format.json { render json: album }
    end
  end  

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])

    @album.user = current_user

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: t('album_was_saved') }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    @album.user = current_user

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to album_pictures_path(@album), notice: t('album_was_saved') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def promote
    album = Album.find(params[:id])
    picture = Picture.find(params[:picture_id])

    respond_to do |format|
      if album.update_attribute(:picture_id, picture.id)
        format.html { redirect_to album_pictures_path(album) }
        format.json { head :no_content }
      else
        format.html { redirect_to album_pictures_path, notice: t('album_promote_error')}
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
