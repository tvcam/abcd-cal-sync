class HomeController < ApplicationController
  def index
    @calendars = current_user.calendars.order(primary: :desc, summary: :asc).limit(50)
  end

  def sync_calendar
    CalendarSync.sync_today(current_user)
    redirect_to root_path, notice: 'Sync success'
  end
end
