class UserDetails < ApplicationRecord
  belongs_to :user

  def to_json
    {
      id:,
      image_url:,
      first_name:,
      last_name:,
      nickname:,
      birthdate:
    }
  end
end
