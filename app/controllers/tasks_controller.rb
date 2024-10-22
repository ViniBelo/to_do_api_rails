class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show update destroy set_categories]

  def index
    render json: {
      tasks: Task.where(context_id: params[:context_id]).map(&:to_json)
    }, status: :ok
  end

  def show
    render json: {
        method: "#{controller_name}##{action_name}",
        task: @task.to_json
      }, status: :ok
  end

  def create
    @task = Task.new(context_id: params[:context_id], **task_params)
    return unprocessable_entity_response unless @task.save!
    render json: {
        method: "#{controller_name}##{action_name}",
        task: @task.to_json
      }, status: :created
  end

  def update
    return unprocessable_entity_response unless @task.update!(task_params)
    render json: {
        method: "#{controller_name}##{action_name}",
        task: @task.to_json
      }, status: :ok
  end

  def destroy
    return unprocessable_entity_response unless @task.destroy!
    render json: { message: "Task deleted successfully" }, status: :no_content
  end

  def set_categories
    category_ids = Category.where(id: categories_params[:category_ids]).map(&:id)
    if category_ids.blank?
      return render json: {
        method: "#{controller_name}##{action_name}",
        message: "Category not found"
      }, status: :not_found
    end
    return unprocessable_entity_response unless category_ids.length == categories_params[:category_ids].length
    category_ids.each do |category_id|
      TaskCategory.create!(task_id: @task.id, category_id:)
    end
    render json: {
      method: "#{controller_name}##{action_name}",
      task: @task.to_json
    }, status: :ok
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date, :progress_id)
  end

  def categories_params
    params.permit(category_ids: [])
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
