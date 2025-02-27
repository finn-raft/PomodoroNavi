class NaviCharacter < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :first_person_pronoun, presence: true
  validates :second_person_pronoun, presence: true
  validates :description, length: { maximum: 300 }
  # 同一ユーザーが複数のナビキャラクターを持てないようにするバリデーション
  validate :unique_user_navi_character, on: :create

  mount_uploader :icon_url, IconUploader

  def self.default
    new(
      name: 'ニャビ',
      first_person_pronoun: 'ニャビ',
      second_person_pronoun: 'ご主人',
      description: '語尾は「ニャ」。性別はメス。ご主人には礼儀正しい敬語口調。ツンデレ。'
    )
  end

  # ユーザーがアイコン画像を設定していない場合、デフォルト画像を表示する
  def icon_image_url
    if icon_url.present?
      icon_url.url
    else
      'default.png'
    end
  end

  private

  # 同一ユーザーが複数のナビキャラクターを持てないようにするバリデーション
  def unique_user_navi_character
    return unless user.navi_character.nil?

    errors.add(:user_id, 'は既にナビキャラクターを登録しています')
  end
end
