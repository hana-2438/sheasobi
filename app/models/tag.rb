class Tag < ApplicationRecord
  has_many :post_comments, dependent: :destroy
end
