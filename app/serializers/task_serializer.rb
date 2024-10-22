class TaskSerializer
  include JSONAPI::Serializer
  attribute :id, :title, :description, :start_date, :end_date, :progress, :task_categories
end
