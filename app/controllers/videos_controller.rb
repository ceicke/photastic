class VideosController < ApplicationController

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

    @videos = Video.where(album_id: @album.id).paginate(:page => params[:page], :per_page => 30).order('created_at DESC')

    respond_to do |format|
      format.html
      format.json { render json: @videos }
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @video = Video.new

    if !current_user && !@album.guests_can_upload
      redirect_to album_videos_path(album_id: @album.id) and return
    end

    if current_user
      authorize! :create, @album
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  def create
    @video = Video.new(video_params)
    @album = Album.find(params[:album_id])

    if !current_user && !@album.guests_can_upload
      redirect_to album_videos_path(album_id: @album.id) and return
    end

    if current_user
      authorize! :create, @album
      @video.user = current_user
    else
      @video.guest_user = cookies[:nickname]
    end

    @video.album = @album

    respond_to do |format|
      if @video.save
        format.html { redirect_to  album_videos_path(album_id: @album), notice: t('video_was_saved') }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @album = Album.find(params[:album_id])
    @video = Video.find(params[:id])
  end

  def update
    @album = Album.find(params[:album_id])
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(video_params)
        format.html { redirect_to album_videos_path(album_id: @album), notice: t('video_was_saved') }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @album = Album.find(params[:album_id])
    @video = Video.find(params[:id])
    # redirect_to video.video_file.url
  end

  def destroy
    album = Album.find(params[:album_id])
    video = Video.find(params[:id])

    video.destroy

    respond_to do |format|
      format.html { redirect_to  album_videos_path(album_id: album) }
      format.json { head :no_content }
    end
  end

  private
  def video_params
    params.require(:video).permit(:description, :video_file_file_name, :created_at)
  end

end
