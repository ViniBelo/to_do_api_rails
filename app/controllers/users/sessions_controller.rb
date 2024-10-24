class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
  return user_not_found_response unless current_user
    render json: {
      status: { code: 200, message: "Logged in sucessfully." },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: {
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  def user_not_found_response
    render json: {
      message: "No user found with given informations."
    }, status: :not_found
  end
end
