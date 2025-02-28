require 'rails_helper'

RSpec.describe NaviCharacter, type: :model do
  let(:user) { User.create(name: "Example User", email: "user@example.com", password: "password") }
  let(:navi_character) { NaviCharacter.new(name: "ニャビ", first_person_pronoun: "ニャビ", second_person_pronoun: "ご主人", description: "語尾は「ニャ」。性別はメス。ご主人には礼儀正しい敬語口調。ツンデレ。", user: user) }

  it "全てのバリデーションを通過している場合、ナビキャラクターを作成できる" do
    expect(navi_character).to be_valid
  end

  it "ナビの名前が空白だと無効である" do
    navi_character.name = nil
    expect(navi_character).to_not be_valid
  end

  it "ナビの一人称が空白だと無効である" do
    navi_character.first_person_pronoun = nil
    expect(navi_character).to_not be_valid
  end

  it "ナビの二人称が空白だと無効である" do
    navi_character.second_person_pronoun = nil
    expect(navi_character).to_not be_valid
  end

  it "ナビの特徴が300文字を超えると無効である" do
    navi_character.description = "a" * 301
    expect(navi_character).to_not be_valid
  end
end