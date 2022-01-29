module Public::NotificationsHelper

  #通知画面の通知文
  def notification_form(notification)
    @visitor = notification.visitor
    case notification.action
    when 'follow' then
      tag.a(notification.visitor.name, href: end_user_path(@visitor)) + 'があなたをフォローしました'
    when 'favorite' then
      tag.a(notification.visitor.name, href: end_user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にいいねしました'
    when 'comment' then
      @post_comment = PostComment.find_by(id: @visiter_post_comment)
      tag.a(@visitor.name, href: end_user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にコメントしました'
    end
  end

  #未読の通知
  def unchecked_notifications
    @notifications = current_end_user.passive_notifications.where(checked: false)
  end

end
