class NaviMessagesController < ApplicationController
    before_action :authenticate_user!

    # 特定の固定メッセージをランダムに表示する（固定メッセージのIDを指定）
    def show_random_message
      @fixed_message = FixedMessage.where(id: 10..10).order('RANDOM()').first
      @response = generate_openai_response(@fixed_message.content, current_user)

      render json: { fixed_message: @fixed_message.content, response: @response }
    end

    # 特定の固定メッセージを表示する
    def show_specific_message
      @fixed_message = FixedMessage.find(params[:id])

      # ポモドーロタイマー使用時に追加情報を表示する
      additional_info = ""
      if params[:cycles]
        additional_info += "ポモドーロ回数: #{params[:cycles]}\n"
      end
      if params[:totalWorkTime]
        additional_info += "作業時間合計: #{params[:totalWorkTime]}分\n"
      end

      @response = generate_openai_response(@fixed_message.content, current_user)
      render json: { fixed_message: @fixed_message.content, response: @response }
    end

    private

    def generate_openai_response(fixed_message, user)
      api_key = ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
      client = OpenAI::Client.new(access_token: api_key)

      system_message = {
        role: 'system',
        content: "あなたは「#{user.navi_character.name}」という名前で、ユーザーのことが大好きなナビキャラクターです。一人称は「#{user.navi_character.first_person_pronoun}」。ユーザーを「#{user.navi_character.second_person_pronoun}」と呼びます。#{user.navi_character.description} ユーザーのプロフィール情報： #{user.profile}"
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