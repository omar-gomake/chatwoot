class Api::V1::Accounts::OauthAuthorizationController < Api::V1::Accounts::BaseController
  before_action :check_authorization

  protected

  def scope
    ''
  end

  def state
    # Accept frontend_url from request body
    frontend_url = params[:frontend_url] || ENV.fetch('FRONTEND_URL', 'http://localhost:3000')
    
    # Encode both account_id and frontend_url in state
    state_data = {
      account_id: Current.account.id,
      frontend_url: frontend_url
    }
    
    # Sign and encode the state using Rails message verifier
    Rails.application.message_verifier('oauth_state').generate(state_data)
  end

  def base_url
    ENV.fetch('FRONTEND_URL', 'http://localhost:3000')
  end

  private

  def check_authorization
    raise Pundit::NotAuthorizedError unless Current.account_user.administrator?
  end
end
