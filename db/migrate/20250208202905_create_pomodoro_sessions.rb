class CreatePomodoroSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :pomodoro_sessions do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :duration, null: false
      t.integer :break_duration, null: false
      t.string :status, null: false
      t.string :mode, null: false

      t.timestamps
    end
  end
end
