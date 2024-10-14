class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[destroy]

  def index
    render json: {
      tasks: Task.where(context_id: params[:context_id])
    }, status: :ok
  end

  def create
    @task = Task.new(context_id: params[:context_id], **task_params)
    return render unprocessable_entity_response unless @task.save!
    render json: @task, status: :created
  end

  def destroy
    return unprocessable_entity_response unless @task.destroy!
    render json: { message: "Task deleted successfully" }, status: :no_content
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date)
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
