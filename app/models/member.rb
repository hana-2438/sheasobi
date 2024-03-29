class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :read_counts, dependent: :destroy

  # フォロー機能
    # フォローした
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    # フォローされた
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォローフォロワー一覧
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 通報機能
  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence:true
  validates :is_deleted, inclusion: [true, false]

  # ゲストユーザーログイン用メソッド
  def self.guest
    find_or_create_by!(email: 'guest@test.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestmember"
    end
  end

  # ゲストユーザーであるかどうかの判定処理
  def guest?
   self.name == 'guestmember' && self.email == 'guest@test.com'
  end

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      profile_image.variant(resize_to_fill: [width, height]).processed
    end
  end

  # フォローした時
  def follow(member_id)
    relationships.create(followed_id: member_id)
  end

  # フォローを外す時
  def unfollow(member_id)
    relationships.find_by(followed_id: member_id).destroy
  end

  # フォローしているかの判定
  def following?(member)
    followings.include?(member)
  end

  # ユーザー検索
  def self.looks(word)
    @member = Member.where("name LIKE?","%#{word}%").where(is_deleted: false)
  end

end
