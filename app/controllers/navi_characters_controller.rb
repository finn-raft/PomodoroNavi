class NaviCharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_navi_character, only: [:edit, :update]
  before_action :show_loading, only: [:new , :edit]

  def new
    @navi_character = NaviCharacter.new
  end

  def create
    @navi_character = current_user.navi_characters.build(navi_character_params)
    if @navi_character.save
      session[:loading_shown] = false
      redirect_to root_path, notice: 'ナビキャラクターが登録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @navi_character.update(navi_character_params)
      session[:loading_shown] = false
      redirect_to root_path, notice: 'ナビキャラクターが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_navi_character
    @navi_character = current_user.navi_character || NaviCharacter.default
  end

  def navi_character_params
    params.require(:navi_character).permit(:name, :first_person_pronoun, :second_person_pronoun, :description, :icon_url,
                                           :icon_url_cache)
  end

  def show_loading
    return if session[:loading_shown]

    session[:loading_shown] = true
    render template: 'pages/loading', locals: { next_page: new_navi_character_path }
  end
end
