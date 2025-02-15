class NaviMessage < ApplicationRecord
  belongs_to :user
  has_many :navi_fixed_messages
  has_many :fixed_messages, through: :navi_fixed_messages
end
