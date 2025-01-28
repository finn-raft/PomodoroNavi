class NaviCharactersController < ApplicationController
  before_action :authenticate_user!

  def new
    @navi_character = NaviCharacter.new
  end

  def create
    @navi_character = current_user.navi_characters.build(navi_character_params)
    if @navi_character.save
      redirect_to @navi_character, notice: 'ナビキャラクターが登録されました。'
    else
      render :new
    end
  end

  private

  def navi_character_params
    params.require(:navi_character).permit(:name, :first_person_pronoun, :second_person_pronoun, :description, :icon_url)
  end
end
