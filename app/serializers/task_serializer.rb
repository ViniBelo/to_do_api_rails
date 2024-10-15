class TaskSerializer
  include JSONAPI::Serializer
  attribute :id, :title, :description, :start_date, :end_date
end
