class Public::RelationshipsController < ApplicationController

  def create
    current_end_user.follow(params[:end_user_id])
    @end_user = EndUser.find(params[:end_user_id])
    @end_user.create_notification_follow!(current_end_user)
    redirect_back(fallback_location: current_end_user)
  end

  def destroy
    current_end_user.unfollow(params[:end_user_id])
    redirect_back(fallback_location: current_end_user)
  end

  #エンドユーザーがフォローしている人の一覧
  def followings
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followings
  end

  #エンドユーザーのフォロワー一覧
  def followers
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followers
  end
end
