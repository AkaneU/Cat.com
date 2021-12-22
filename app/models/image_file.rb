class ImageFile < ApplicationRecord

  belongs_to :post

  attachment :image

end
