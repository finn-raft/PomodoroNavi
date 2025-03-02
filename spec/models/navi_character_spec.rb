require 'rails_helper'

RSpec.describe NaviCharacter, type: :model do
  let(:user) { User.create(name: "Test User", email: "test@example.com", password: "password") }
  let(:navi_character) { NaviCharacter.create(name: "ニャビ", first_person_pronoun: "ニャビ", second_person_pronoun: "ご主人", user: user) }

  describe "バリデーション" do
    it "ユーザーのナビキャラクターを保存できる" do
      expect(navi_character).to be_valid
    end

    it "ナビの名前が空白の場合無効である" do
      navi_character.name = nil
      expect(navi_character).to_not be_valid
    end

    it "ナビの一人称が空白の場合無効である" do
      navi_character.first_person_pronoun = nil
      expect(navi_character).to_not be_valid
    end

    it "ナビのあなたの呼び方がない場合無効である" do
      navi_character.second_person_pronoun = nil
      expect(navi_character).to_not be_valid
    end

    it "ナビの特徴が300文字を超える場合無効である" do
      navi_character.description = "a" * 301
      expect(navi_character).to_not be_valid
    end
  end

  describe "デフォルトのナビキャラクターの表示" do
    it "ナビキャラクターを登録していない及び未ログインの場合、デフォルトのナビキャラクター（ニャビ）を表示する" do
      default_navi_character = NaviCharacter.default
      expect(default_navi_character.name).to eq 'ニャビ'
      expect(default_navi_character.first_person_pronoun).to eq 'ニャビ'
      expect(default_navi_character.second_person_pronoun).to eq 'ご主人'
      expect(default_navi_character.description).to eq '語尾は「ニャ」。性別はメス。ご主人には礼儀正しい敬語口調。ツンデレ。'
    end
  end

  describe "アイコン画像の表示" do
    it "ユーザーがアイコン画像を設定していない場合、デフォルト画像を表示する" do
      expect(navi_character.icon_image_url).to eq 'default.png'
    end
  end
end