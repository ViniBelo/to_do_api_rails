class CategorySerializer
  include JSONAPI::Serializer
  attribute :id, :name, :description, :color
end
