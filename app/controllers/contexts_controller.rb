class ContextsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      contexts: Context.where(user_id: current_user.id)
    }, status: :ok
  end

  def create
    context = Context.new(user_id: current_user.id, **context_params)
    return unprocessable_entity_json(context) unless context.save
    render json: context, status: :created
  end

  def update
    context = Context.find_by(id: params[:id])
    return unprocessable_entity_json(context) unless context.update(context_params)
    render json: context, status: :ok
  end

  private

  def context_params
    params.require(:context).permit(:title, :description)
  end

  def unprocessable_entity_json(context)
    render json: context, status: :unprocessable_entity_json
  end
end
