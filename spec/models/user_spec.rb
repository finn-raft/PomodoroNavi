require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ユーザーがログインできる' do
    user = User.new(name: 'Example User', email: 'user@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'ユーザーが名前なしでは無効である' do
    user = User.new(name: nil, email: 'user@example.com')
    expect(user).to_not be_valid
  end

  it 'ユーザーがメールアドレスなしでは無効である' do
    user = User.new(name: 'Example User', email: nil)
    expect(user).to_not be_valid
  end

  it 'ユーザーのメールアドレスが一意である' do
    User.create(name: 'Example User', email: 'user@example.com')
    user = User.new(name: 'Another User', email: 'user@example.com')
    expect(user).to_not be_valid
  end
end
