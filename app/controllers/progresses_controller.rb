class ProgressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_progress, only: %i[show update destroy]

  def index
    render json: {
      method: "#{controller_name}##{action_name}",
      progresses: Progress.where(context_id: params[:context_id]).map(&:to_json)
    }, status: :ok
  end

  def show
    render json: {
      method: "#{controller_name}##{action_name}",
      progress: @progress.to_json
    }, status: :ok
  end

  def create
    @progress = Progress.new(context_id: params[:context_id], **progress_params)
    return unprocessable_entity_response unless @progress.save!
    render json: {
      method: "#{controller_name}##{action_name}",
      progress: @progress.to_json
    }, status: :created
  end

  def update
    return unprocessable_entity_response unless @progress.update!(progress_params)
    render json: {
      method: "#{controller_name}##{action_name}",
      progress: @progress.to_json
    }, status: :ok
  end

  def destroy
    return unprocessable_entity_response unless @progress.destroy!
    render json: {
      method: "#{controller_name}##{action_name}",
      message: "Progress deleted successfully"
    }, status: :no_content
  end

  private

  def progress_params
    params.require(:progress).permit(:name, :color)
  end

  def serialize_progress(progress)
    ProgressSerializer.new(progress).serializable_hash[:data][:attributes]
  end

  def set_progress
    @progress = Progress.find_by(id: params[:id], context_id: params[:context_id])
    not_found_response if @progress.blank?
  end

  def not_found_response
    render json: {
      method: "#{controller_name}##{action_name}",
      message: "Not found progress with given id"
    }, status: :not_found
  end

  def unprocessable_entity_response
    render json: {
      method: "#{controller_name}##{action_name}",
      progress: @progress
    }, status: :unprocessable_entity
  end
end
