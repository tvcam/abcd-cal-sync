class SessionsController < ApplicationController
  skip_before_action :authorize_user!

  def new
    client = Signet::OAuth2::Client.new(CalendarSync.oauth2_client_options)
    @auth_url = client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(CalendarSync.oauth2_client_options)
    client.code = params[:code]
    response = client.fetch_access_token!

    if response['scope'].exclude?(Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS_READONLY) || response['scope'].exclude?(Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY)
      flash[:error] = 'You need to authorize all requested scopes!'
      redirect_to(authorize_path)
    else
      begin
        user = setup_user(response)
        CalendarSync.sync_today(user)
        redirect_to root_path, notice: 'Authorize success'
      rescue GoogleIDToken::ValidationError => e
        flash[:error] = e.message
        redirect_to root_path
      end
    end
  rescue Signet::AuthorizationError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Log out success'
  end

  private

  def setup_user(access_token_response)
    validator = GoogleIDToken::Validator.new
    payload = validator.check(access_token_response['id_token'], Rails.application.credentials.google_client_id)
    user = User.find_or_create_by(email: payload['email'], google_user_id: payload['sub'])
    user.update_columns(access_token: access_token_response['access_token'], refresh_token: access_token_response['refresh_token'])
    session[:user_id] = user.id

    user
  end
end
