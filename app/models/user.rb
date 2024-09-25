class User < ApplicationRecord
  after_create :create_user_details
  has_one :user_details

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  private

  def create_user_details
    UserDetails.create(user: self)
  end
end
