class PasscodesController < ApplicationController

  skip_before_filter :authenticate_user!

  def new
    @album = Album.find(params[:album_id])
  end

  def create
    @album = Album.find(params[:album_id])

    if @album.passcode == params[:passcode] && !params[:nickname].blank?
      cookies.permanent[:album_passcode] = params[:passcode]
      cookies.permanent[:nickname] = params[:nickname]
      redirect_to album_pictures_path(@album)
    else
      render 'new'
    end
  end
end