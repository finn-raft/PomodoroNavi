class PomodoroSessionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    @pomodoro_session = current_user.pomodoro_sessions.new(pomodoro_session_params)
    if @pomodoro_session.save
      render json: @pomodoro_session, status: :created
    else
      Rails.logger.error(@pomodoro_session.errors.full_messages.join(", "))
      render json: @pomodoro_session.errors, status: :unprocessable_entity
    end
  end

  def reports
    @daily_sessions = PomodoroSession.where(start_time: Time.zone.today.all_day)
    @weekly_sessions = PomodoroSession.where(start_time: Time.zone.today.all_week)
    @monthly_sessions = PomodoroSession.where(start_time: Time.zone.today.all_month)
    @yearly_sessions = PomodoroSession.where(start_time: Time.zone.today.all_year)

    @daily_total = @daily_sessions.sum(:duration)
    @weekly_total = @weekly_sessions.sum(:duration)
    @monthly_total = @monthly_sessions.sum(:duration)
    @yearly_total = @yearly_sessions.sum(:duration)

    @sessions = PomodoroSession.all
  end

  private

  def pomodoro_session_params
    params.require(:pomodoro_session).permit(:start_time, :end_time, :duration, :break_duration, :status, :mode)
  end
end