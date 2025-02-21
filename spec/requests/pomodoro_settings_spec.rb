require 'rails_helper'

RSpec.describe 'PomodoroSettings', type: :request do
  describe 'GET /edit' do
    it 'ログインしている場合、設定ページを表示する' do
      user = User.create!(name: "Test User", email: "test@example.com", password: "password")
      sign_in user
      get edit_pomodoro_settings_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    let(:valid_attributes) { { work_duration: 25, break_duration: 5 } }

    it "設定ページの設定を更新できる" do
      patch pomodoro_settings_path, params: { pomodoro_setting: valid_attributes }
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "設定ページで設定したパラメータを取得する" do
      get show_pomodoro_settings_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /default_pomodoro_settings" do
    it "デフォルトのポモドーロタイマーの設定を取得する" do
      get default_pomodoro_settings_path
      expect(response).to have_http_status(:success)
    end
  end
end
