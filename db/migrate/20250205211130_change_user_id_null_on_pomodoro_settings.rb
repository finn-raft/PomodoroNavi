class ChangeUserIdNullOnPomodoroSettings < ActiveRecord::Migration[7.1]
  def change
    change_column_null :pomodoro_settings, :user_id, true
  end
end
