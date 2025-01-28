class NaviCharacter < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :first_person_pronoun, presence: true
  validates :second_person_pronoun, presence: true
  validates :description, presence: true
  validates :icon_url, presence: true
end
