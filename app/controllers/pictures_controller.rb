class PicturesController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:index, :show]
  before_filter :check_album_passcode, only: [:index, :show]
  load_and_authorize_resource except: [:index, :show, :create], param_method: :picture_params

  def index
    if request.subdomain.blank?
      @album = Album.find(params[:album_id])
    else
      @album = Album.find_by_subdomain(request.subdomain)
    end

    @pictures = Picture.where(album_id: @album.id).paginate(:page => params[:page], :per_page => 30).order("created_at DESC")

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
    @picture = Picture.new(picture_params)
    @album = Album.find(params[:album_id])

    @picture.user = current_user
    @picture.album = @album

    respond_to do |format|
      if @picture.save
        format.html { redirect_to album_pictures_path(album_id: @album), notice: t('picture_was_saved') }
        format.json { render json: @picture, status: :created }
      else
        format.html { render action: 'new'}
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
