class ContextsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_context, only: %i[ show update destroy ]

  def index
    render json: {
      method: "#{controller_name}##{action_name}",
      contexts: Context.where(user_id: current_user.id).map do |context|
        serialize_context(context)
      end
    }, status: :ok
  end

  def show
    render json: {
      method: "#{controller_name}##{action_name}",
      context: serialize_context(@context)
    }, status: :ok
  end

  def create
    @context = Context.new(user_id: current_user.id, **context_params)
    return unprocessable_entity_response unless @context.save
    render json: {
      method: "#{controller_name}##{action_name}",
      context: serialize_context(@context)
    }, status: :created
  end

  def update
    return unprocessable_entity_response unless @context.update(context_params)
    render json: {
      method: "#{controller_name}##{action_name}",
      context: serialize_context(@context)
    }, status: :ok
  end

  def destroy
    return unprocessable_entity_response unless @context.destroy!
    render json: {
      method: "#{controller_name}##{action_name}",
      message: "Context deleted successfully"
    }, status: :no_content
  end

  private

  def context_params
    params.require(:context).permit(:title, :description)
  end

  def serialize_context(context)
    ContextSerializer.new(context).serializable_hash[:data][:attributes]
  end

  def set_context
    @context = Context.find_by(id: params[:id])
    not_found_response if @context.blank?
  end

  def not_found_response
    render json: {
      method: "#{controller_name}##{action_name}",
      message: "Not found context with given id"
    }, status: :not_found
  end

  def unprocessable_entity_response
    render json: {
      method: "#{controller_name}##{action_name}",
      context: @context
    }, status: :unprocessable_entity
  end
end
