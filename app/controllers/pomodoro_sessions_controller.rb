class PomodoroSessionsController < ApplicationController
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
end