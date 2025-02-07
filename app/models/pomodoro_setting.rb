class PomodoroSetting < ApplicationRecord
    belongs_to :user, optional: true

    validates :work_duration, :short_break_duration, :long_break_duration, :long_break_cycle, presence: true
    validates :work_duration, :short_break_duration, :long_break_duration, :long_break_cycle, numericality: { only_integer: true, greater_than: 0 }
    validates :background_color, :header_footer_color, presence: true

  def self.default
    new(
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4,
        auto_start_work: true,
        auto_start_break: true,
        alarm_on: true,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
    )
  end
end