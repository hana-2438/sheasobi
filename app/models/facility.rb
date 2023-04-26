class Facility < ApplicationRecord

  has_many :post_facilities, dependent: :destroy
  has_many :posts, through: :post_facilities, dependent: :destroy

end
