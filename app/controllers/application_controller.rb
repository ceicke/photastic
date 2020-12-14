class ApplicationController < ActionController::Base

  protect_from_forgery

  before_action :authenticate_user!, :set_locale

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

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
  end

  def check_album_passcode
    if request.subdomain.blank?
      album = Album.find(params[:album_id])
    else
      album = Album.find_by_subdomain(request.subdomain)
    end

    if current_user.blank?
      if cookies[:album_passcode] == album.passcode && !cookies[:nickname].blank?
        @guest_authenticated = true
      else
        @guest_authenticated = false
        redirect_to new_album_passcode_path(album)
      end
    end
  end

  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first unless request.env['HTTP_ACCEPT_LANGUAGE'].blank?
  end
end
