class ApplicationController < ActionController::API
  def authenticate_user!
    render json: { error: "Not authenticated" }, status: :unauthorized unless user_signed_in?
  end
end
