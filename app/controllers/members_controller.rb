class MembersController < ApplicationController

  load_and_authorize_resource
  before_filter :check_album_manage_permission

  def index
    @album = Album.find(params[:album_id])   
    @members = @album.members

    respond_to do |format|
      format.html
      format.json { render json: @album.members }
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @users = User.all
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  def create
    @album = Album.find(params[:album_id])
    @member = Member.new(params[:member])

    @member.album = @album

    respond_to do |format|
      if @member.save
        format.html { redirect_to album_members_path(@album), notice: t('member_added') }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @album = Album.find(params[:album_id])
    @member = Member.find(params[:id])
  end

  def update
    @album = Album.find(params[:album_id])
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to album_members_path(@album), notice: t('membership_saved') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    album = Album.find(params[:album_id])
    member = Member.find(params[:id])

    member.destroy

    respond_to do |format|
      format.html { redirect_to album_members_path }
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

end