require 'rails_helper'

RSpec.describe PomodoroSession, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  it 'ユーザーのポモドーロタイマーの作業時間を保存できる' do
    pomodoro_session = PomodoroSession.new(
      user: user,
      start_time: Time.current,
      end_time: 25.minutes.from_now,
      duration: 25,
      break_duration: 5,
      status: 'active',
      mode: 'work'
    )
    expect(pomodoro_session).to be_valid
  end

  it '作業時間がnilの場合は保存されない' do
    pomodoro_session = PomodoroSession.new(
      user: user,
      start_time: Time.current,
      end_time: 25.minutes.from_now,
      duration: nil,
      break_duration: 5,
      status: 'active',
      mode: 'work'
    )
    expect(pomodoro_session).to_not be_valid
  end

  it '作業時間が1分以下の場合は保存されない' do
    pomodoro_session = PomodoroSession.new(
      user: user,
      start_time: Time.current,
      end_time: 25.minutes.from_now,
      duration: 0,
      break_duration: 5,
      status: 'active',
      mode: 'work'
    )
    expect(pomodoro_session).to_not be_valid
  end
end
