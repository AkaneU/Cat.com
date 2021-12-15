class Notification < ApplicationRecord

  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: "EndUser", foreign_key: "visiter_id", optional: true
  belongs_to :visited, class_name: "EndUser", foreign_key: "visited_id", optional: true

end
