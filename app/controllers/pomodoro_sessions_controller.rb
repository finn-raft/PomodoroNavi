class PomodoroSessionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  # ポモドーロ時間の記録
  def create

    @pomodoro_session = current_user.pomodoro_sessions.new(pomodoro_session_params)
    if @pomodoro_session.save
      render json: @pomodoro_session, status: :created
    else
      Rails.logger.error(@pomodoro_session.errors.full_messages.join(", "))
      render json: @pomodoro_session.errors, status: :unprocessable_entity
    end
  end

  # レポートページの表示
  def reports_day
    @daily_total = PomodoroSession.where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).sum(:duration)
    @hourly_data = (0..23).map do |hour|
      PomodoroSession.where(start_time: Time.zone.now.beginning_of_day + hour.hours..Time.zone.now.beginning_of_day + (hour + 1).hours).sum(:duration)
    end
    @daily_total_formatted = format_duration(@daily_total)
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
end