class Progress < ApplicationRecord
  belongs_to :context
  has_many :task

  def to_json
    {
      id:,
      name:,
      color:
    }
  end
end
