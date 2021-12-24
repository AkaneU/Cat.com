class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_end_user.passive_notifications.order(created_at: :desc).page(params[:page]).per(15)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
