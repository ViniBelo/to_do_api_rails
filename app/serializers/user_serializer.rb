class UserSerializer
  include JSONAPI::Serializer
  attribute :email, :user_details
end
