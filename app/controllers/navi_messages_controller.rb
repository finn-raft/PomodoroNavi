class NaviMessagesController < ApplicationController
  before_action :set_navi_character, only: [:show_specific_message, :show_random_message]

  # ナビキャラクターからの自動送信メッセージを生成するほうのコントローラー
  # 特定の固定メッセージをランダムに表示する（には固定メッセージのIDを指定）
  def show_random_message
    @fixed_message = FixedMessage.where(id: 10..32).order('RANDOM()').first
    @response = generate_openai_response(@fixed_message.content, current_user, @navi_character)

    render json: { fixed_message: @fixed_message.content, response: @response }
  end

  # 特定の固定メッセージを表示する
  def show_specific_message
    @fixed_message = FixedMessage.find(params[:id])

    # ポモドーロタイマー使用後、現在の記録をメッセージの下部に表示する
    additional_info = ''
    additional_info += "ポモドーロサイクル: #{params[:cycles]} 回\n" if params[:cycles]
    additional_info + "作業時間合計: #{params[:totalWorkTime]} 分\n" if params[:totalWorkTime]

    @response = generate_openai_response(@fixed_message.content, current_user, @navi_character)
    render json: { fixed_message: @fixed_message.content, response: @response }
  end

  private

  def set_navi_character
    @navi_character = current_user&.navi_character || NaviCharacter.default
  end

  # ナビキャラクターの自動送信メッセージを生成する関数
  def generate_openai_response(fixed_message, user, navi_character)
    api_key = ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
    client = OpenAI::Client.new(access_token: api_key)

    # 未ログイン時はユーザーのプロフィール情報を取得しない
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
          { role: 'user', content: fixed_message }
        ]
      }
    )

    response.dig('choices', 0, 'message', 'content') || nil
  end
end