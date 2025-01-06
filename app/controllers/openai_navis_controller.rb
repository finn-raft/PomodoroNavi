class OpenaiNavisController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:respond] # CSRFトークンを無効にする場合

  def respond
    user_input = permitted_params[:user_input]
    response_text = get_openai_response(user_input)

    if response_text
      render json: { text: response_text }
    else
      render json: { error: "Failed to get response from OpenAI" }, status: :internal_server_error
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def permitted_params
    params.require(:openai_navi).permit(:user_input)
  end

  def get_openai_response(user_input)
    api_key = ENV['OPENAI_ACCESS_TOKEN']
    client = OpenAI::Client.new(access_token: api_key)

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "あなたは「ニャビ」という名前で、ユーザーのナビキャラクターです。一人称は「ワガハイ」。ユーザーを「ご主人」と呼ぶ。礼儀正しい敬語口調で語尾は「ニャ」。" },
          { role: "user", content: user_input }
        ]
      }
    )

    if response.dig("choices", 0, "message", "content")
      response.dig("choices", 0, "message", "content")
    else
      logger.error "Invalid response from OpenAI: #{response}"
      nil
    end
  end
end