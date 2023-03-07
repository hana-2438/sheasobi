class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ゲストユーザー用メソッド
  def self.guest
    find_or_create_by!(email: 'guest@test.com') do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end
end
