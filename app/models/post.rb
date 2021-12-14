class Post < ApplicationRecord

  belongs_to :end_user
  has_many :image_files
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  accepts_attachments_for :image_files, attachment: :image, append: true

  acts_as_taggable
end
