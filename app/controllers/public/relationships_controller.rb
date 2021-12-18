class Public::RelationshipsController < ApplicationController

  def create
    current_end_user.follow(params[:end_user_id])
    end_user.create_notification_follow!(current_end_user)
    redirect_back(fallback_location: current_end_user)
  end

  def destroy
    current_end_user.unfollow(params[:end_user_id])
    redirect_back(fallback_location: current_end_user)
  end

  def followings
    @end_user = EndUser.find(params[:end_user_id])
    @end_user = end_user.followings
  end

  def followers
    @end_user = EndUser.find(params[:end_user_id])
    @end_user = end_user.followers
  end
end
