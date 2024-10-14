class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      tasks: Task.where(context_id: params[:context_id])
    }, status: :ok
  end

  def create
    @task = Task.new(context_id: params[:context_id], **permit_params)
    return render unprocessable_entity_response unless @task.save!
    render json: @task, status: :created
  end

  private

  def permit_params
    params.require(:task).permit(:title, :description, :start_date, :end_date)
  end

  def unprocessable_entity_response
    render json: @task, status: :unprocessable_entity
  end
end
