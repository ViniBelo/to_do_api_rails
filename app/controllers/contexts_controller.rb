class ContextsController < ApplicationController
  def index
    render json: {
      contexts: Context.where(user_id: current_user.id)
    }, status: :ok
  end

  def create
    context_params = permit_params
    context = Context.create!(user_id: current_user.id, **context_params)
    render json: context, status: :created
  end

  private

  def permit_params
    params.require(:context).permit(:title, :description)
  end
end
