class ApplicationController < ActionController::Base

  protect_from_forgery
  
  before_filter :authenticate_user!

  layout :layout_by_resource

  def layout_by_resource
    if user_signed_in?
      'application'
    else
      'unauthorized'
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def check_album_passcode
    if request.subdomain.blank?
      album = Album.find(params[:album_id])
    else
      album = Album.find_by_subdomain(request.subdomain)
    end
    
    if current_user.blank?
      unless cookies[:album_passcode] == album.passcode && !cookies[:nickname].blank?
        redirect_to new_album_passcode_path(album)
      end
    end
  end
end
