class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @recent_posts = @end_user.posts.first(3)
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

  def create_notification_follow!(current_end_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_end_user.id, id, 'follow'])
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email, :profile_image)
  end

end
