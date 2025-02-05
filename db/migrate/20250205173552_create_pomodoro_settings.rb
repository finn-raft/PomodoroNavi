class CreatePomodoroSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :pomodoro_settings do |t|
      t.integer :work_duration, default: 25, null: false
      t.integer :short_break_duration, default: 5, null: false
      t.integer :long_break_duration, default: 15, null: false
      t.integer :long_break_cycle, default: 4, null: false
      t.boolean :auto_start_work, default: true, null: false
      t.boolean :auto_start_break, default: true, null: false
      t.boolean :alarm_on, default: true, null: false
      t.string :background_color, null: false

      t.timestamps
    end
  end
end
