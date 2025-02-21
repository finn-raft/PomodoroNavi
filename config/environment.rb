# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  # その他の設定

  # アセットのダイジェストを有効にする
  config.assets.digest = true

  # アセットのデバッグを有効にする
  config.assets.debug = true

  # アセットのプリコンパイル
  config.assets.compile = false

  # アセットのプリコンパイルパス
  config.assets.precompile += %w(
    application.js
    timer.js
    navi.js
    application.css
    top.css
    formpage.css
    timer.css
    navi_message.css
    report.css
    pages.css
    audios/alarm.mp3
  )
end