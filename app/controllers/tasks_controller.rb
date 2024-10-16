class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show update destroy]

  def index
    render json: {
      tasks: Task.where(context_id: params[:context_id]).map do |task|
        serialize_task(task)
      end
    }, status: :ok
  end

  def show
    render json: {
        method: "#{controller_name}##{action_name}",
        task: serialize_task(@task)
      }, status: :ok
  end

  def create
    @task = Task.new(context_id: params[:context_id], **task_params)
    return unprocessable_entity_response unless @task.save!
    render json: {
        method: "#{controller_name}##{action_name}",
        task: serialize_task(@task)
      }, status: :created
  end

  def update
    return unprocessable_entity_response unless @task.update!(task_params)
    render json: {
        method: "#{controller_name}##{action_name}",
        task: serialize_task(@task)
      }, status: :ok
  end

  def destroy
    return unprocessable_entity_response unless @task.destroy!
    render json: { message: "Task deleted successfully" }, status: :no_content
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date)
  end

  def serialize_task(task)
    TaskSerializer.new(task).serializable_hash[:data][:attributes]
  end

  def set_task
    @task = Task.find_by(id: params[:id], context_id: params[:context_id])
    not_found_response if @task.blank?
  end

  def not_found_response
    render json: { message: "Not found task with given id" }, status: :not_found
  end

  def unprocessable_entity_response
    render json: @task, status: :unprocessable_entity
  end
end
