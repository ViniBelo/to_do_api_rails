class UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: {
        user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
  end

  def update
    update_user_details
    render json: {
      user_details: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  private

  def update_user_details
    user_details = params.permit(:nickname, :first_name, :last_name, :image_url, :birthdate)
    current_user.user_details.update(user_details)
  end
end
