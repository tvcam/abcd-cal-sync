class CalendarSync
  class Unauthorized < ::StandardError; end

  CALENDARS_ENDPOINT = 'https://www.googleapis.com/calendar/v3/users/me/calendarList'
  EVENTS_ENDPOINT = 'https://www.googleapis.com/calendar/v3/calendars/:calendar_id/events'

  attr_reader :user, :start_at, :end_at

  def self.oauth2_client_options
    {
      client_id: Rails.application.credentials.google_client_id,
      client_secret: Rails.application.credentials.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: [Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS_READONLY, Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY, 'https://www.googleapis.com/auth/userinfo.email'],
      redirect_uri: 'http://localhost:3000/google_sign_in/callback'
    }
  end

  def initialize(user)
    @user = user
  end

  def sync_today
    sync(Date.current.beginning_of_day, Date.current.end_of_day)
  end

  def sync(start_at, end_at)
    @start_at = start_at.rfc3339
    @end_at = end_at.rfc3339

    calendars = fetch_calendars
    calendars.each do |google_calendar|
      calendar = user.calendars.find_or_create_by(google_id: google_calendar['id'])
      calendar.update_columns(primary: google_calendar['primary'], summary: google_calendar['summary'])

      events = fetch_events(calendar.google_id)
      events.each do |google_event|
        event = calendar.events.find_or_create_by(google_id: google_event['id'])

        start_date = google_event.dig('start', 'dateTime')
        start_date ||= google_event.dig('start', 'date')

        end_date = google_event.dig('end', 'dateTime')
        end_date ||= google_event.dig('end', 'date')

        event.update_columns(
          attendees: google_event['attendees'],
          creator: google_event['creator'],
          event_end: google_event['end'],
          event_start: google_event['start'],
          description: google_event['description'],
          status: google_event['status'],
          summary: google_event['summary'],
          start_at: start_date,
          end_at: end_date
        )
      end
    end
  end

  private

  def fetch_calendars
    @calendar ||= make_request(CALENDARS_ENDPOINT)
  end

  def fetch_events(calendar_id)
    events_endpoint = EVENTS_ENDPOINT.gsub(':calendar_id', calendar_id)
    # events_endpoint = "#{events_endpoint}?timeMax=#{end_at}&timeMin=#{start_at}"
    make_request(events_endpoint)
  end

  def make_request(endpoint)
    puts "making request #{endpoint}"
    url = URI(endpoint)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request['authorization'] = "Bearer #{user.access_token}"
    response = http.request(request)

    raise Unauthorized.new(response.message) if response.message == 'Unauthorized'

    return [] if response.message == 'Not Found'

    JSON.parse(response.body)['items']
  end
end
