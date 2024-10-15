class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @category = Category.new(context_id: params[:context_id], **category_params)
    return unprocessable_entity_response unless @category.save!
    render json: {
      method: "#{controller_name}##{action_name}",
      category: serialize_category(@category)
    }
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :color)
  end

  def serialize_category(category)
    CategorySerializer.new(category).serializable_hash[:data][:attributes]
  end

  def unprocessable_entity_response
    render json: {
      method: "#{controller_name}##{action_name}",
      category: @category
    }, status: :unprocessable_entity
  end
end
