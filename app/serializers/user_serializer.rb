class UserSerializer
  include JSONAPI::Serializer
  attribute :email

  attribute :user_details do |user|
    user.user_details.to_json
  end
end
