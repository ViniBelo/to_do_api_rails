class CreateUserDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :user_details, id: :uuid do |t|
      t.references :user, type: :uuid, index: true, null: false, foreign_key: { on_delete: :cascade }
      t.string :image_url
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.date :birthdate
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
