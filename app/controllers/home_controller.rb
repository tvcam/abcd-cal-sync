class HomeController < ApplicationController
  def index
    @calendars = current_user.calendars.order(primary: :desc, summary: :asc).limit(50)
  end

  def sync_calendar
    attempt_times ||= 1
    CalendarSync.sync_today(current_user)
    redirect_to root_path, notice: 'Sync success'
  rescue CalendarSync::Unauthorized
    if attempt_times <= 1
      attempt_times += 1
      current_user.refresh_token!
      retry
    end
  end
end
