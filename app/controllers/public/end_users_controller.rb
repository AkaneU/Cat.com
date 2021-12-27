class Public::EndUsersController < ApplicationController
  before_action :ensure_end_user, only: [:edit, :update]

  def show
    @end_user = EndUser.find(params[:id])
    @recent_posts = @end_user.posts.first(3)
  end

  def end_user_posts
  end_user = EndUser.find(params[:id])
    @posts = end_user.posts.page(params[:page]).per(10)
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

  def ensure_end_user
    @end_user != current_end_user
    redirect_to end_user_path(current_end_user)
  end

  def end_user_params
    params.require(:end_user).permit(:name, :email, :profile_image)
  end

end
