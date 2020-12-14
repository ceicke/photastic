class VideoCallbacksController < ApplicationController

  protect_from_forgery except: :callback
  skip_before_action :authenticate_user!, :set_locale

  def callback
    video = Video.find(params[:video_id])
   
    video.set_encoded!
 
    render nothing: true, status: 200
  end

end
