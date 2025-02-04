class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # 新規登録時にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ログイン時に許可するパラメーターを追加
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # プロフィール更新時に許可するパラメーターを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
  end
end
