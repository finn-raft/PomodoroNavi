class PomodoroSetting < ApplicationRecord
    belongs_to :user, optional: true

    validates :work_duration, :short_break_duration, :long_break_duration, :long_break_cycle, presence: true
    validates :work_duration, :short_break_duration, :long_break_duration, :long_break_cycle, numericality: { only_integer: true, greater_than: 0 }
    validates :background_color, :header_footer_color, presence: true
end