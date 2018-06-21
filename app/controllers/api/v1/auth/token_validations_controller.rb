class Api::V1::Auth::TokenValidationsController < DeviseTokenAuth::TokenValidationsController
  include SetCacheControlHeader
  
  def render_validate_token_success
    render json: @resource
  end
end