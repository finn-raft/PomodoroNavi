class OpenaiNavisController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:respond] # CSRFトークンを無効にする
  before_action :set_navi_character, only: [:respond]

  def respond
    user_input = permitted_params[:user_input]
    response_text = get_openai_response(user_input, @navi_character, current_user)

    if response_text
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
    @navi_character = current_user&.navi_characters&.first || NaviCharacter.default
  end

  def get_openai_response(user_input, navi_character, user)
    api_key = ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
    client = OpenAI::Client.new(access_token: api_key)

  # 未ログイン時はプロフィール情報を取得しない
  def user_profile_message(user)
    user&.profile.present? ? user.profile : 'プロフィール情報はありません。'
  end

    system_message = {
      role: 'system',
      content: "あなたは「#{navi_character.name}」という名前で、ユーザーのことが大好きなナビキャラクターです。一人称は「#{navi_character.first_person_pronoun}」。ユーザーを「#{navi_character.second_person_pronoun}」と呼びます。#{navi_character.description} ユーザーのプロフィール情報： #{user_profile_message(user)}'"
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