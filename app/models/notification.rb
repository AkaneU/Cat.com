class Notification < ApplicationRecord

  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visitor, class_name: "EndUser", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "EndUser", foreign_key: "visited_id", optional: true

  enum action: { follow: 1, favorite: 2, comment: 3 }

end
