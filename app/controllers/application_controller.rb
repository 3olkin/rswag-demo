class ApplicationController < ActionController::Base
  rescue_from StandardError do
    head :internal_server_error
  end

  before_action :authenticate_user!

  def render_json(data = nil, status: :ok, errors: nil)
    payload = { data: data, errors: errors }
    render json: payload.compact, status: status
  end

  def current_user
    @current_user ||= authenticate_with_http_token do |token, _options|
      decoded = JsonWebToken.decode(token)
      User.find_by_id(decoded[:sub])
    end
  end

  def authenticate_user!
    return head :unauthorized unless current_user
  end
end
