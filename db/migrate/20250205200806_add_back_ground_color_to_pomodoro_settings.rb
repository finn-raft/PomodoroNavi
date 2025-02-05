class AddBackGroundColorToPomodoroSettings < ActiveRecord::Migration[7.1]
  def change
    change_column_default :pomodoro_settings, :background_color, "#419DC4"
    add_column :pomodoro_settings, :header_footer_color, :string, default: '#0073e6', null: false
  end
end
