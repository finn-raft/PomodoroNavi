class NaviCharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_navi_character, only: [:new, :create]

  def new
    @navi_character = NaviCharacter.new
  end

  def create
    @navi_character = current_user.navi_characters.build(navi_character_params)
    if @navi_character.save
      redirect_to root_path, notice: 'ナビキャラクターが登録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_navi_character
    @navi_character = current_user.navi_characters.first || NaviCharacter.default
  end

  def navi_character_params
    params.require(:navi_character).permit(:name, :first_person_pronoun, :second_person_pronoun, :description, :icon_url, :icon_url_cache)
  end
end
