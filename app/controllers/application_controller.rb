class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_pomodoro_settings
  before_action :set_navi_character

  def configure_permitted_parameters
    # 新規登録時にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ログイン時に許可するパラメーターを追加
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # プロフィール更新時に許可するパラメーターを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
  end

  private

  # ユーザーのポモドーロタイマー設定を取得する
  def set_pomodoro_settings
    @pomodoro_settings = current_user&.pomodoro_setting || PomodoroSetting.default
  end

  # ユーザーのナビキャラクターを取得する
  def set_navi_character
    @navi_character = current_user&.navi_character || NaviCharacter.default
  end
end
