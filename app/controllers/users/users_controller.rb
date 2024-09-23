class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  def user_info
    render json: {
        user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
  end
end
