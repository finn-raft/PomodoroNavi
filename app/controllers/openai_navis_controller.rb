class OpenaiNavisController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:respond]
  before_action :set_navi_character, only: [:respond]

  # ユーザーからのメッセージに対してナビキャラクターの返答を返すほうのコントローラー
  def respond
    user_input = permitted_params[:user_input]
    response_text = get_openai_response(user_input, @navi_character, current_user)

    if response_text
      if user_signed_in?
        # 過去のメッセージ履歴を取得（最新5件）
        past_messages = NaviMessage.where(user_id: current_user.id).order(created_at: :desc).limit(5)
        context = past_messages.map { |msg| "User: #{msg.user_message}\nNavi: #{msg.response}" }.join("\n")

        # DB（Navi_Messagesテーブル)に保存
        NaviMessage.create!(
          user_id: current_user.id,
          user_message: user_input,
          response: response_text,
          context: context
        )
      end

      render json: { text: response_text }
    else
      render json: { error: 'Failed to get response from OpenAI' }, status: :internal_server_error
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def permitted_params
    params.require(:openai_navi).permit(:user_input)
  end

  def set_navi_character
    @navi_character = current_user&.navi_character || NaviCharacter.default
  end

  # ユーザーからの入力に対してナビキャラクターの応答を生成するための関数
  def get_openai_response(user_input, navi_character, user)
    api_key = ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
    client = OpenAI::Client.new(access_token: api_key)

    context = if user
                past_messages = NaviMessage.where(user_id: user.id).order(created_at: :desc).limit(5)
                past_messages.map { |msg| "User: #{msg.user_message}\nNavi: #{msg.response}" }.join("\n")
              else
                ''
              end

    system_message = {
      role: 'system',
      content: "あなたは「#{navi_character.name}」という名前で、ユーザーのことが大好きなナビキャラクターです。一人称は「#{navi_character.first_person_pronoun}」。ユーザーを「#{navi_character.second_person_pronoun}」と呼びます。#{navi_character.description} 過去の会話:\n#{context}"
    }

    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          system_message,
          { role: 'user', content: user_input }
        ]
      }
    )

    response.dig('choices', 0, 'message', 'content') || nil
  end
end