class CommentsController < ApplicationController

  skip_before_action :authenticate_user!, :only => :create
  before_action :check_album_passcode, :only => :create
  load_and_authorize_resource except: [:create, :destroy]

  def create
    @album = Album.find(params[:album_id])
    @comment = Comment.new(comment_params)

    # set user or nickname
    if current_user.blank?
      @comment.nickname = cookies[:nickname]
    else
      @comment.user = current_user
    end

    # set the back link to the ID of the object, so that we can jump to the a-target on that page
    unless request.referer.blank?
      back_url = request.referer + '#' + @comment.commentable_id.to_s
    else
      back_url = :back
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to back_url, notice: t('comment_was_saved') }
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

    # set the back link to the ID of the object, so that we can jump to the a-target on that page
    unless request.referer.blank?
      back_url = request.referer + '#' + comment.commentable_id.to_s
    else
      back_url = :back
    end

    comment.destroy

    respond_to do |format|
      format.html { redirect_to back_url, notice: t('comment_was_deleted') }
      format.json { head :no_content }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:nickname, :user_id, :comment, :commentable_id, :commentable_type)
  end
end
