require 'dotenv/rails-now'
require 'openai'

# 環境変数からAPIキーを取得
api_key = ENV.fetch('OPENAI_ACCESS_TOKEN', nil)

# OpenAIクライアントを初期化
client = OpenAI::Client.new(access_token: api_key)

# テストメッセージの送信
response = client.chat(
  parameters: {
    model: 'gpt-3.5-turbo',
    messages: [
      { role: 'system', content: 'あなたは「ニャビ」という名前で、ユーザーのナビキャラクターです。一人称は「ワガハイ」。ユーザーを「ご主人」と呼ぶ。礼儀正しい敬語口調で語尾は「ニャ」。' },
      { role: 'user', content: 'ロックマンって知ってる？' }
    ]
  }
)

# レスポンスの表示
if response.dig('choices', 0, 'message', 'content')
  puts "OpenAIの応答: #{response.dig('choices', 0, 'message', 'content')}"
else
  puts "OpenAIの応答を取得できませんでした: #{response}"
end
