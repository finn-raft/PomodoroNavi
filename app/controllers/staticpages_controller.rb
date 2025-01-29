class StaticpagesController < ApplicationController
  before_action :set_navi_character

  def top; end

  private

  def set_navi_character
    if current_user
      @navi_character = current_user.navi_characters.first || NaviCharacter.default
    else
      @navi_character = NaviCharacter.default
    end
  end
end
