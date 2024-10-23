class Context < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :progresses, dependent: :destroy

  def to_json
    {
      id:,
      title:,
      description:
    }
  end
end
