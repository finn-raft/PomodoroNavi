# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :show_loading, only: [:new]
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  protected

  def after_resetting_password_path_for(resource)
    # パスワードリセット後のリダイレクト先を指定
    session[:loading_shown] = false
    root_path
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    # パスワード申請後のリダイレクト先を指定
    session[:loading_shown] = false
    new_user_session_path
  end

  def show_loading
    unless session[:loading_shown]
      session[:loading_shown] = true
      render template: 'pages/loading', locals: { next_page: new_user_session_path }
    end
  end
end
