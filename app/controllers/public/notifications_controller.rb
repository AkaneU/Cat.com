class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_end_user.passive_notifications.order(created_at: :desc).page(params[:page]).per(15)
    #未読の通知をindexアクションを行うことで既読に変更する
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
