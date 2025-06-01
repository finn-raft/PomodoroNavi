FactoryBot.define do
  factory :pomodoro_setting do
    user
    work_duration { 25 }
    short_break_duration { 5 }
    long_break_duration { 15 }
    long_break_cycle { 4 }
    auto_start_work { true }
    auto_start_break { true }
    alarm_on { true }
  end
end