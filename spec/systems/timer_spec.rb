require 'rails_helper'

RSpec.describe 'Pomodoro Timer', type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    # ユーザーとしてログイン(Factoriesで作成したユーザーを使用)
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    # デフォルトのポモドーロ設定(Factoriesで作成したデフォルトのポモドーロ設定を使用)
    FactoryBot.create(:pomodoro_setting, user: user)
  end

  scenario '「Start」でタイマーを開始し、「Stop」で一時停止する' do
    visit root_path
    click_button 'Start'

    expect(page).to have_content('25:00')
    expect(page).to have_content('作業中')

    click_button 'Stop'
    expect(page).to have_content('Start')
  end

  scenario '「Stop」でタイマーを一時停止し、「START」でタイマーを再開する' do
    visit root_path
    click_button 'Start'
    click_button 'Stop'

    expect(page).to have_content('Start')

    click_button 'Start'
    expect(page).to have_content('Stop')
  end

  scenario '作業タイマーのカウントダウンが終了し、休憩タイマーに移行する' do
    visit root_path
    click_button 'Start'
    travel_to(Time.now + 25.minutes) do
      expect(page).to have_content('休憩中')
    end
  end

  scenario 'タイマーのカウンドダウンが終了したときにアラームが鳴る' do
    visit root_path
    click_button 'Start'
    travel_to(Time.now + 25.minutes) do
      expect(page).to have_selector('audio#alarm-sound')
    end
  end

  scenario 'ログインユーザーが「End」をクリックすると作業時間等が記録される' do
    visit root_path
    click_button 'Start'
    click_button 'End'

    expect(PomodoroSession.count).to eq(1)
    session = PomodoroSession.last
    expect(session.duration).to eq(25)
    expect(session.break_duration).to eq(0)
    expect(session.status).to eq('completed')
    expect(session.mode).to eq('work')
  end

  scenario 'タイマー稼働中にUIが正しく更新される' do
    visit root_path
    click_button 'Start'

    expect(page).to have_content('作業中')
    expect(page).to have_content('25:00')

    click_button 'Stop'
    expect(page).to have_content('Start')

    click_button 'End'
    expect(page).to have_content('Start')
  end
end
