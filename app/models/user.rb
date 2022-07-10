class User < ApplicationRecord
  has_many :calendars, dependent: :delete_all
  has_many :events, through: :calendars

  def refresh_token!
    client = Signet::OAuth2::Client.new(CalendarSync.oauth2_client_options)
    client.update!(refresh_token:)
    response = client.refresh!
    update_columns(access_token: response['access_token'])
  end
end
