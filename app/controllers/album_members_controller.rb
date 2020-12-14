class AlbumMembersController < ApplicationController

  load_and_authorize_resource
  before_action :check_album_manage_permission

  def index
    @album = Album.find(params[:album_id])   
    @album_members = @album.album_members

    respond_to do |format|
      format.html
      format.json { render json: @album.album_members }
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @users = User.all
    @album_member = AlbumMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album_member }
    end
  end

  def create
    @album = Album.find(params[:album_id])
    @album_member = AlbumMember.new(album_member_params)

    @album_member.album = @album

    respond_to do |format|
      if @album_member.save
        format.html { redirect_to album_album_members_path(@album), notice: t('member_added') }
        format.json { render json: @album_member, status: :created, location: @album_member }
      else
        format.html { render action: "new" }
        format.json { render json: @album_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @album = Album.find(params[:album_id])
    @album_member = AlbumMember.find(params[:id])
  end

  def update
    @album = Album.find(params[:album_id])
    @album_member = AlbumMember.find(params[:id])

    respond_to do |format|
      if @album_member.update_attributes(album_member_params)
        format.html { redirect_to album_album_members_path(@album), notice: t('membership_saved') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    album = Album.find(params[:album_id])
    album_member = AlbumMember.find(params[:id])

    album_member.destroy

    respond_to do |format|
      format.html { redirect_to album_album_members_path }
      format.json { head :no_content }
    end
  end

  private
  def check_album_manage_permission
    @album = Album.find(params[:album_id])

    unless can? :manage, @album
      raise CanCan::AccessDenied
    end
  end

  def album_member_params
    params.require(:album_member).permit(:album_id, :can_addphotos, :can_administer, :user_id)
  end

end