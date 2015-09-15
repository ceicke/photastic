class PicturesController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:index, :show, :new, :create]
  before_filter :check_album_passcode, only: [:index, :show, :new, :create]

  def index
    if request.subdomain.blank?
      @album = Album.find(params[:album_id])
    else
      @album = Album.find_by_subdomain(request.subdomain)
    end

    if current_user
      authorize! :manage, @album
    end

    @pictures = Picture.where(album_id: @album.id).paginate(:page => params[:page], :per_page => 30).order("created_at DESC")
    @all_pictures = Picture.where(album_id: @album.id).order("created_at DESC")

    respond_to do |format|
      format.html
      format.json { render json: @all_pictures }
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @picture = Picture.new

    if !current_user && !@album.guests_can_upload
      redirect_to album_pictures_path(album_id: @album.id) and return
    end

    if current_user
      authorize! :create, @album
    end

    respond_to do |format|
      format.html
      format.json { render json: @picture }
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @album = Album.find(params[:album_id])

    if !current_user && !@album.guests_can_upload
      redirect_to album_pictures_path(album_id: @album.id) and return
    end

    if current_user
      authorize! :create, @album
      @picture.user = current_user
    else
      @picture.guest_user = cookies[:nickname]
    end

    @picture.album = @album

    respond_to do |format|
      if @picture.save
        format.html { redirect_to album_pictures_path(album_id: @album), notice: t('picture_was_saved') }
        format.json { render json: @picture, status: :created }
      else
        format.html { render action: 'new'}
        p @picture.errors
        format.json { render json @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @album = Album.find(params[:album_id])
    @picture = Picture.find(params[:id])
  end

  def update
    @album = Album.find(params[:album_id])
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(picture_params)
        format.html { redirect_to album_pictures_path(album_id: @album), notice: t('picture_was_saved') }
        format.json { render json: @picture, status: :created, location: @picture }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @album = Album.find(params[:album_id])
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: picture }
    end
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
  def picture_params
    params.require(:picture).permit(:description, :picture_file)
  end

end
