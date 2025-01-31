class StaticpagesController < ApplicationController
  before_action :set_navi_character
  before_action :show_loading, only: [:top]

  def top; end

  private

  def set_navi_character
    if current_user
      @navi_character = current_user.navi_characters.first || NaviCharacter.default
    else
      @navi_character = NaviCharacter.default
    end
  end

  def show_loading
    unless session[:loading_shown]
      session[:loading_shown] = true
      render template: 'pages/loading', locals: { next_page: root_path }
    end
  end
end
