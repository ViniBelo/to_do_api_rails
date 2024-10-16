class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show update]

  def index
    render json: {
      method: "#{controller_name}##{action_name}",
      categories: Category.where(context_id: params[:context_id]).map do |category|
        serialize_category(category)
      end
    }, status: :ok
  end

  def show
    render json: {
      method: "#{controller_name}##{action_name}",
      category: serialize_category(@category)
    }, status: :ok
  end

  def create
    @category = Category.new(context_id: params[:context_id], **category_params)
    return unprocessable_entity_response unless @category.save!
    render json: {
      method: "#{controller_name}##{action_name}",
      category: serialize_category(@category)
    }, status: :created
  end

  def update
    return unprocessable_entity_response unless @category.update!(category_params)
    render json: {
      method: "#{controller_name}##{action_name}",
      category: serialize_category(@category)
    }, status: :ok
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :color)
  end

  def serialize_category(category)
    CategorySerializer.new(category).serializable_hash[:data][:attributes]
  end

  def set_category
    @category = Category.find_by(id: params[:id], context_id: params[:context_id])
    not_found_response if @category.blank?
  end

  def not_found_response
    render json: {
      method: "#{controller_name}##{action_name}",
      message: "Not found category with given id"
    }, status: :not_found
  end

  def unprocessable_entity_response
    render json: {
      method: "#{controller_name}##{action_name}",
      category: @category
    }, status: :unprocessable_entity
  end
end