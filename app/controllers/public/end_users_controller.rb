class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user != current_end_user
      redirect_to end_user_path(current_end_user.id)
    else
      if @end_user.update(end_user_params)
        redirect_to end_user_path(current_end_user.id)
      else
        render :edit
      end
    end
  end

  def checks
  end

  def withdrawal
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email, :profile_image)
  end

end
