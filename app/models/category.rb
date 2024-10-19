class Category < ApplicationRecord
  belongs_to :context
  has_many :task_categories, dependent: :destroy
end
