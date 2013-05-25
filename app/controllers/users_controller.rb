class UsersController < ApplicationController

  load_and_authorize_resource

  def edit
    @user = current_user
  end

  def update

    @user = current_user

    respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to albums_path(@album), notice: t('membership_saved') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end