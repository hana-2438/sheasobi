class Region < ApplicationRecord
  has_many :posts, dependent: :destroy
end
