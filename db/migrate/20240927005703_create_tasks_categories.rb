class CreateTasksCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks_categories, id: :uuid do |t|
      t.references :tasks, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :categories, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
