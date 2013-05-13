class PicturesController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:index, :show]
  before_filter :check_album_passcode, only: [:index, :show]
  #load_and_authorize_resource

  def index
    @album = Album.find(params[:album_id])
    @pictures = Picture.where(album_id: @album.id)

    respond_to do |format|
      format.html
      format.json { render json: @pictures }
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  def create
    @picture = Picture.new(params[:picture])
    @album = Album.find(params[:album_id])

    @picture.user = current_user
    @picture.album = @album

    respond_to do |format|
      if @picture.save
        format.html { redirect_to album_pictures_path(album_id: @album), notice: t('picture_was_saved') }
        format.json { render json: @picture, status: :created, location: @picture }
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    album = Album.find(params[:album_id])
    picture = Picture.find(params[:id])

    send_file picture.picture_file.path
  end

  def destroy
    album = Album.find(params[:album_id])
    picture = Picture.find(params[:id])

    picture.destroy

    respond_to do |format|
      format.html { redirect_to album_pictures_path(album_id: album) }
      format.json { head :no_content }
    end
  end

  private
  def check_album_passcode
    album = Album.find(params[:album_id])
    if current_user.blank?
      unless cookies[:album_passcode] == album.passcode
        redirect_to new_album_passcode_path(album)
      end
    end
  end
end
