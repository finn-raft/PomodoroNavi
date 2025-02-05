class PomodoroSettingsController < ApplicationController
  before_action :authenticate_user!, except: [:show_default] # show_defaultアクションはログインしていなくてもアクセス可能
  before_action :show_loading, only: [:edit]

  def edit
    @pomodoro_settings = current_user.pomodoro_setting || current_user.build_pomodoro_setting
  end

  def update
    @pomodoro_settings = current_user.pomodoro_setting || current_user.build_pomodoro_setting
    if @pomodoro_settings.update(pomodoro_settings_params)
      session[:loading_shown] = false
      redirect_to root_path, notice: 'ポモドーロタイマーの設定を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # デフォルトのポモドーロタイマー設定を参照するメソッド（未ログインユーザー用）
  def show_default
    @pomodoro_settings = PomodoroSetting.find_by(user_id: nil)
    render json: @pomodoro_settings
  end

  private

  def show_loading
    return if session[:loading_shown]

    session[:loading_shown] = true
    render template: 'pages/loading', locals: { next_page: root_path }
  end

  def pomodoro_settings_params
    params.require(:pomodoro_setting).permit(
      :work_duration,
      :short_break_duration,
      :long_break_duration,
      :long_break_cycle,
      :auto_start_work,
      :auto_start_break,
      :alarm_on,
      :background_color,
      :header_footer_color
    )
  end
end