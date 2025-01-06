require 'dotenv/rails-now'
require 'openai'

OpenAI.configure do |config|
  config.access_token = ENV['OPENAI_API_KEY']
end