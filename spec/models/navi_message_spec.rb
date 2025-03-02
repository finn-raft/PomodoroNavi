require 'rails_helper'

RSpec.describe NaviMessage, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  it 'ユーザーがナビにメッセージを送信すると、メッセージとそれに対する回答と最新のコンテキストが保存される' do
    navi_message = NaviMessage.new(
      user: user,
      user_message: 'こんにちは、調子はどう？',
      response: '元気です！今日はどんな作業をしますか？',
      context: 'User:こんにちは、調子はどう？ Navi:元気です！今日はどんな作業をしますか？'
    )
    expect(navi_message).to be_valid
    expect { navi_message.save }.to change { NaviMessage.count }.by(1)
  end

  it '未ログインの場合、Navimessageテーブルにデータが保存されない' do
    navi_message = NaviMessage.new(
      user: nil,
      user_message: 'こんにちは、調子はどう？',
      response: '元気です！今日はどんな作業をしますか？',
      context: 'User:こんにちは、調子はどう？ Navi:元気です！今日はどんな作業をしますか？'
    )
    expect(navi_message).to_not be_valid
  end
end
