class Inquiry < ApplicationRecord

  belongs_to :end_user, optional: true

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :title, presence: true
  validates :text, presence: true

end
