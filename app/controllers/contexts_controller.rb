class ContextsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      contexts: Context.where(user_id: current_user.id)
    }, status: :ok
  end

  def create
    context = Context.create!(user_id: current_user.id, **context_params)
    render json: context, status: :created
  end

  def update
    context = Context.find_by(id: params[:id])
    context.update!(context_params)
    render json: context, status: :ok
  end

  private

  def context_params
    params.require(:context).permit(:title, :description)
  end
end
