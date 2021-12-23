class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_end_user.passive_notifications.order(created_at: :desc)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
