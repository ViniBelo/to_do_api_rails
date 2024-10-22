class Task < ApplicationRecord
  belongs_to :context
  belongs_to :progress, optional: true
  has_many :task_categories, dependent: :destroy
  has_many :categories, through: :task_categories

  def to_json
    {
      id:,
      title:,
      description:,
      start_date:,
      end_date:,
      progress: progress&.to_json,
      categories: categories.map(&:to_json)
    }
  end
end
