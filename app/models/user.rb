class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  has_one :navi_character
  has_one :pomodoro_setting
  has_many :pomodoro_sessions, dependent: :destroy
  has_many :navi_messages

  validates :name, presence: true, length: { maximum: 20 }
  validates :profile, length: { maximum: 300 }
  validates :password, presence: true, on: :create # パスワードは新規登録時のみ必須

  # Google認証のためのメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # ナビキャラクターが登録されているかどうかを判定するメソッド
  def navi_character_registered?
    navi_character.present?
  end
end
