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
end
