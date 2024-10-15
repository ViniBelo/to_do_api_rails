class ContextsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_context, only: %i[ show update destroy ]

  def index
    render json: {
      contexts: Context.where(user_id: current_user.id)
    }, status: :ok
  end

  def show
    render json: @context, status: :ok
  end

  def create
    @context = Context.new(user_id: current_user.id, **context_params)
    return unprocessable_entity_response unless @context.save
    render json: @context, status: :created
  end

  def update
    return unprocessable_entity_response unless @context.update(context_params)
    render json: @context, status: :ok
  end

  def destroy
    return unprocessable_entity_response unless @context.destroy!
    render json: { message: "Context deleted successfully" }, status: :no_content
  end

  private

  def context_params
    params.require(:context).permit(:title, :description)
  end

  def set_context
    @context = Context.find_by(id: params[:id])
    not_found_response if @context.blank?
  end

  def not_found_response
    render json: { message: "Not found context with given id" }, status: :not_found
  end

  def unprocessable_entity_response
    render json: @context, status: :unprocessable_entity
  end
end
