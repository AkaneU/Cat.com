class Post < ApplicationRecord

  belongs_to :end_user
  has_many :image_files
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  accepts_attachments_for :image_files, attachment: :image, append: true

  acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests

  validates :title, presence: true, length: { maximum: 50}
  validates :text, presence: true, length: { maximum: 200}
  validates :image_files, presence: true


  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

  def create_notification_favorite!(current_end_user)
    temp = Notification.where(["visitor_id = ? and visited_id and post_id = ? and action = ?", current_end_user.id, end_user.id, 'favorite'])
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        post_id: id,
        visited_id: end_user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_end_user, post_comment_id)
    temp_ids = PostComment.where(post_id: id).where.not("end_user_id=? or end_user_id=?", current_end_user.id, end_user_id).select(:end_user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_end_user, post_comment_id, temp_id['end_user_id'])
    end
    save_notification_comment!(current_end_user, post_comment_id, end_user_id)
  end

  def save_notification_comment!(current_end_user, post_comment_id, visited_id)
    notification = current_end_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
