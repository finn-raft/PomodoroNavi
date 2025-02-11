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

# ナビキャラクター用の固定メッセージの追加
FixedMessage.find_or_create_by!(content: 'お疲れ様です！')
FixedMessage.find_or_create_by!(content: '頑張ってください！')
FixedMessage.find_or_create_by!(content: 'あと少しです！')
FixedMessage.find_or_create_by!(content: '素晴らしい進捗です！')
FixedMessage.find_or_create_by!(content: '休憩を忘れずに！')
FixedMessage.find_or_create_by!(content: '挨拶をしたあと、ユーザーが作業に対してやる気を出せる応援をしましょう！「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '作業を始めたユーザーを励ましましょう！「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '作業をしたユーザーを褒めたあと、少し休憩を促しましょう！「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: 'お疲れ様と作業を終えたユーザーを労ったあと、たくさん褒めましょう！')
FixedMessage.find_or_create_by!(content: '勉強に関する豆知識を話しましょう！「もちろん」などの言葉はいりません')