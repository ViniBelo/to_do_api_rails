class CreateContexts < ActiveRecord::Migration[7.1]
  def change
    create_table :contexts, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
