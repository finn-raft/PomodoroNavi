require 'rails_helper'

RSpec.describe PomodoroSetting, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  describe 'バリデーション' do
    it 'ユーザーのポモドーロタイマーの設定を保存できる' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to be_valid
    end

    it '作業時間が空白の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: nil,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '休憩時間が空白の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: nil,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '長い休憩が空白の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: nil,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '長い休憩のサイクルが空白の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: nil,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it 'アプリの背景色が空白の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: nil,
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it 'アプリのヘッダー/フッターの色が空白の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: nil
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '作業時間が整数でない場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25.5,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '休憩時間が整数でない場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5.5,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '長い休憩時間が整数でない場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15.5,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '長い休憩のサイクルが整数でない場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4.5,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '作業時間が0以下の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 0,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '休憩時間が0以下の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 0,
        long_break_duration: 15,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '長い休憩時間が0以下の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 0,
        long_break_cycle: 4,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end

    it '長い休憩のサイクルが0以下の場合無効である' do
      pomodoro_setting = PomodoroSetting.new(
        user: user,
        work_duration: 25,
        short_break_duration: 5,
        long_break_duration: 15,
        long_break_cycle: 0,
        background_color: '#419DC4',
        header_footer_color: '#0073e6'
      )
      expect(pomodoro_setting).to_not be_valid
    end
  end

  describe 'タイマー及びアプリカラーのデフォルト設定' do
    it '初期設定及び未ログイン時にデフォルトのポモドーロ設定の値を反映する' do
      default_setting = PomodoroSetting.default
      expect(default_setting.work_duration).to eq(25)
      expect(default_setting.short_break_duration).to eq(5)
      expect(default_setting.long_break_duration).to eq(15)
      expect(default_setting.long_break_cycle).to eq(4)
      expect(default_setting.auto_start_work).to eq(true)
      expect(default_setting.auto_start_break).to eq(true)
      expect(default_setting.alarm_on).to eq(true)
      expect(default_setting.background_color).to eq('#419DC4')
      expect(default_setting.header_footer_color).to eq('#0073e6')
    end
  end
end
