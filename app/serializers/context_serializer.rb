class ContextSerializer
  include JSONAPI::Serializer
  attribute :id, :title, :description
end
