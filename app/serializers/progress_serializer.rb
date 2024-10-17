class ProgressSerializer
  include JSONAPI::Serializer
  attribute :id, :name, :color
end
