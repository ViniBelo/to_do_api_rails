class CreateProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :progresses, id: :uuid do |t|
      t.references :context, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.string :name
      t.string :color
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
