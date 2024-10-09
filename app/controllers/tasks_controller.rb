class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      tasks: Task.where(context_id: params[:context_id])
    }, status: :ok
  end

  def create
    task_params = permit_params
    Task.create!(task_params)
  end

  private

  def permit_params
    params.require(:task).permit(:context_id, :title, :description, :start_date, :end_date)
  end
end
