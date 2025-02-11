class FixedMessage < ApplicationRecord
    has_many :navi_fixed_messages
    has_many :navi_messages, through: :navi_fixed_messages
end
