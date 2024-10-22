class Category < ApplicationRecord
  belongs_to :context
  has_many :task_categories, dependent: :destroy
  has_many :categories, through: :task_categories

  def to_json
    {
      id:,
      name:,
      description:,
      color:
    }
  end
end
