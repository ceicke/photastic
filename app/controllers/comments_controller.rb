class CommentsController < ApplicationController

  skip_before_filter :authenticate_user!, :only => :create
  before_filter :check_album_passcode, :only => :create
  load_and_authorize_resource except: [:create, :destroy]

  def create
    @album = Album.find(params[:album_id])
    picture = Picture.find(params[:picture_id])
    @comment = Comment.new(params[:comment])

    # set user or nickname
    if current_user.blank?
      @comment.nickname = cookies[:nickname]
    else
      @comment.user = current_user
    end

    # set picture
    @comment.picture = picture

    back_url = request.referer

    respond_to do |format|
      if @comment.save
        format.html { redirect_to back_url + '#' + picture.id.to_s, notice: t('comment_was_saved') }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to :back, alert: t('comment_was_not_saved') + @comment.errors.inspect.to_s }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    album = Album.find(params[:album_id])
    comment = Comment.find(params[:id])

    comment.destroy

    respond_to do |format|
      format.html { :back }
      format.json { head :no_content }
    end
  end
end
