class FixedMessage < ApplicationRecord
    belongs_to :user
    has_many :navi_fixed_messages
    has_many :navi_messages, through: :navi_fixed_messages
end
