class AddUserIdToPomodoroSessions < ActiveRecord::Migration[7.1]
  def change
    add_reference :pomodoro_sessions, :user, null: false, foreign_key: true
  end
end
