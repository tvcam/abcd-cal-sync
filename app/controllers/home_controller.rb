class HomeController < ApplicationController
  def index
    @calendars = current_user.calendars.order(primary: :desc, summary: :asc).limit(50)
  end
end
