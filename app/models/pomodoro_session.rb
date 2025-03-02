class PomodoroSession < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :break_duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[active pause completed] }
  validates :mode, inclusion: { in: %w[work break] }
end
