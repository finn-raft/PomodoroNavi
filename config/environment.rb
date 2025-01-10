# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  # その他の設定

  # アセットのダイジェストを有効にする
  config.assets.digest = true

  # アセットのプリコンパイル
  config.assets.compile = false

  # アセットのプリコンパイルパス
  config.assets.precompile += %w( application.js application.css )
end