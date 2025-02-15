class PomodoroSessionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  # ポモドーロ時間の記録
  def create

    @pomodoro_session = current_user.pomodoro_sessions.new(pomodoro_session_params)
    if @pomodoro_session.save
      render json: @pomodoro_session, status: :created
    else
      render json: @pomodoro_session.errors, status: :unprocessable_entity
    end
  end

  # レポートページの表示
  def reports_day
    @daily_total = PomodoroSession.where(
      start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day,
      user: current_user
    ).sum(:duration)

    @daily_total_formatted = format_duration(@daily_total)
    @hourly_data = calculate_hourly_data
  end

  def reports_week
    @weekly_total = PomodoroSession.where(start_time: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).sum(:duration)
    @weekly_data = (0..6).map do |day|
      PomodoroSession.where(start_time: Time.zone.now.beginning_of_week + day.days..Time.zone.now.beginning_of_week + (day + 1).days).sum(:duration)
    end
    @weekly_total_formatted = format_duration(@weekly_total)
  end

  def reports_month
    @monthly_total = PomodoroSession.where(start_time: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum(:duration)
    @days_in_month = Time.days_in_month(Time.zone.now.month, Time.zone.now.year)
    @daily_data = (1..@days_in_month).map do |day|
      PomodoroSession.where(start_time: Time.zone.now.beginning_of_month + (day - 1).days..Time.zone.now.beginning_of_month + day.days).sum(:duration)
    end
    @monthly_total_formatted = format_duration(@monthly_total)
  end

  def reports_year
    @yearly_total = PomodoroSession.where(start_time: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year).sum(:duration)
    @monthly_data = (1..12).map do |month|
      PomodoroSession.where(start_time: Time.zone.now.beginning_of_year + (month - 1).months..Time.zone.now.beginning_of_year + month.months).sum(:duration)
    end
    @yearly_total_formatted = format_duration(@yearly_total)
  end

  def reports_calendar
    @sessions = PomodoroSession.all
    @total_duration = @sessions.sum(:duration)
    @total_duration_formatted = format_duration(@total_duration)
  end

  private

  # ポモドーロの合計作業時間を「時間:分」の形式に整形する
  def format_duration(duration)
    hours = duration / 60
    minutes = duration % 60
    "#{hours} 時間 #{minutes} 分"
  end

  def pomodoro_session_params
    params.require(:pomodoro_session).permit(:start_time, :end_time, :duration, :break_duration, :status, :mode)
  end

  # 1時間ごとの作業時間を計算する
  def calculate_hourly_data
    hourly_data = Array.new(24, 0) # 24時間分の作業時間配列

    # 今日のポモドーロセッションを取得
    sessions = PomodoroSession.where(
      start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day,
      user: current_user
    )

    sessions.each do |session|
      start_time = session.start_time
      duration = session.duration

      while duration > 0
        hour_index = start_time.hour
        remaining_minutes_in_hour = 60 - (hourly_data[hour_index] % 60)
        minutes_to_add = [remaining_minutes_in_hour, duration].min

        hourly_data[hour_index] += minutes_to_add
        duration -= minutes_to_add
        start_time += 1.hour

        # 日付を超えた場合、翌日の 0:00 から加算
        if start_time.day != Time.zone.today.day
          start_time = start_time.change(hour: 0)
        end
      end
    end

    hourly_data
  end
end