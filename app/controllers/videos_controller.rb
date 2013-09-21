class VideosController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:index, :show]
  before_filter :check_album_passcode, only: [:index, :show]
  load_and_authorize_resource except: [:index, :show]

  def index
    if request.subdomain.blank?
      @album = Album.find(params[:album_id])
    else
      @album = Album.find_by_subdomain(request.subdomain)
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  def create
    @video = Video.new(params[:video])
    @album = Album.find(params[:album_id])

    @video.user = current_user
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

  def show
    album = Album.find(params[:album_id])
    video = Video.find(params[:id])

    redirect_to video.video_file.url
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
  
end
