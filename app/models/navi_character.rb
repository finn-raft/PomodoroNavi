class NaviCharacter < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :first_person_pronoun, presence: true
  validates :second_person_pronoun, presence: true
  validates :icon_url, presence: { message: "のファイルを添付してください" }

  # 同一ユーザーが複数のナビキャラクターを持てないようにするバリデーション
  validate :unique_user_navi_character, on: :create

  mount_uploader :icon_url, IconUploader

  def self.default
    new(
      name: "ニャビ",
      first_person_pronoun: "ワガハイ",
      second_person_pronoun: "ご主人",
      description: "語尾は「ニャ」。ご主人には礼儀正しい敬語口調"
    )
  end

  private

  def unique_user_navi_character
    if user.navi_characters.exists?
      errors.add(:user_id, "は既にナビキャラクターを登録しています")
    end
  end
end
