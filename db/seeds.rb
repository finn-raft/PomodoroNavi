# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# PomodoroSettingのデフォルト値を設定
PomodoroSetting.find_or_create_by!(
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

# ナビキャラクターの固定メッセージの追加
user = User.first

FixedMessage.find_or_create_by!(content: '頑張ってください！', user: user)
FixedMessage.find_or_create_by!(content: '素晴らしい進捗です！', user: user)
FixedMessage.find_or_create_by!(content: 'お疲れ様です！', user: user)
FixedMessage.find_or_create_by!(content: '休憩を忘れずに！', user: user)