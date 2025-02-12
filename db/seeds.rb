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
FixedMessage.find_or_create_by!(content: '健康に関する豆知識を話しましょう！「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '作業を継続できているユーザーをたくさん褒めてください！「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「最も面倒な課題を朝一番にやり遂げるのが最善」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「読書は70%以上のストレス軽減効果があるいう研究結果が出ている」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「とりあえず10分間だけやってみよう。最大の試練は、それに取り掛かること」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「自分にご褒美をあげましょう。課題とご褒美をセットのタスクにするといい」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「日々の予定表を埋めてみると、取り組む課題を見極められる」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「各課題に優先順位を付けることは、その課題の目標を明確にするのに役立つ」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「ToDoリストを短縮しよう。多すぎると圧倒されて身動きが取れなくなる」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「課題に制限時間を設定しよう。課題の期限が明確になる」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「誰かに締め切りを設定してもらおう。自分で設定するよりも効果が高い」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「1日の中で自分が集中できる時間を活用しよう。作業時間のレポートを振り返ってみよう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「誰かに目標を宣言しよう。大切なのは、自分が目標を果たしたことを確認してくれる相手を見つけること」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「大きな課題を、ひとつひとつの小さな課題に細分化しよう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「退屈な作業はゲーム化しよう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「集中を乱す環境要因を取り除こう。作業以外にやることのない環境を作ろう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「作業時間を細切れに分割しよう。『Pomodoro Navi』を活用しよう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「目標の達成に関係のない些細な課題を排除しよう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「ひとつの課題にフォーカスしよう。シングルタスキングは習慣である」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「ネガティブな思い込みはやめよう」という文章と、あなたから沢山の応援を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「課題を先延ばししそうになったら、自分の今の状態を見つめよう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')
FixedMessage.find_or_create_by!(content: '「毎週、目標を見直そう。ToDoリストを整理しよう」という文章と、あなたの見解を伝えてください。「もちろん」などの言葉はいりません')