class CreateTaskCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :task_categories, id: :uuid do |t|
      t.references :task, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :category, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
