class UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: {
        user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
  end

  def update
    update_user_details
  end

  private

  def authenticate_user!
    render json: { error: "Not authenticated" }, status: :unauthorized unless user_signed_in?
  end

  def update_user_details
    user_details = params.permit(:nickname, :first_name, :last_name, :image_url, :birthdate)
    current_user.user_detail.update(user_details)
  end
end
