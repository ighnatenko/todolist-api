# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
    end
  end

  def current_ability
    @current_ability = Ability.new(current_api_user)
  end
end
