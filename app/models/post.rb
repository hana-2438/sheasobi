class Post < ApplicationRecord
  belongs_to :member
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_members, through: :favorites, source: :member
  has_many :read_counts, dependent: :destroy
  belongs_to :tag
  belongs_to :region

  has_one_attached :image

  validates :title, presence: true
  validates :place, presence: true
  validates :caption, presence: true


  # joinsでmemberを結合し、whereで退会ユーザーを除外したすべてのユーザーを取得。is_not_deleted格納
  scope :is_not_deleted, -> { joins(:member).where(member: { is_deleted: false }) }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/post_noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def self.looks(word)
    @post = Post.where(["title LIKE? OR place LIKE?","%#{word}%","%#{word}%"]).joins(:member).where(member: { is_deleted: false })
  end
end
