class GoogleSignInController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validator_google_token

  def callback
    validator = GoogleIDToken::Validator.new
    user = validator.check(params[:credential], Rails.application.credentials.google_client_id)
    puts user
  end

  private

  def validator_google_token
  end
end
