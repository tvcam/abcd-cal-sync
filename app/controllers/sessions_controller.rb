class SessionsController < ApplicationController
  skip_before_action :authorize_user!

  def new
    client = Signet::OAuth2::Client.new(oauth2_client_options)
    @auth_url = client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(oauth2_client_options)
    validator = GoogleIDToken::Validator.new
    client.code = params[:code]
    response = client.fetch_access_token!

    begin
      payload = validator.check(response['id_token'], Rails.application.credentials.google_client_id)
      user = User.find_or_create_by(email: payload['email'], google_user_id: payload['sub'])
      user.update_columns(access_token: response['access_token'], refresh_token: payload['refresh_token'])
      session[:user_id] = user.id

      redirect_to root_path, notice: 'Authorize success'
    rescue GoogleIDToken::ValidationError => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Log out success'
  end

  private

  def oauth2_client_options
    {
      client_id: Rails.application.credentials.google_client_id,
      client_secret: Rails.application.credentials.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: [Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS_READONLY, Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY, 'https://www.googleapis.com/auth/userinfo.email'],
      redirect_uri: 'http://localhost:3000/google_sign_in/callback'
    }
  end
end
