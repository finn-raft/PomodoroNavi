# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
PomodoroSetting.create!(
  work_duration: 25,
  short_break_duration: 5,
  long_break_duration: 15,
  long_break_cycle: 4,
  auto_start_work: true,
  auto_start_break: true,
  alarm_on: true,
  background_color: "#419DC4",
  header_footer_color: "#0073e6"
)