class TasksCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks_categories, id: :uuid do |t|
      t.references :tasks, type: :uuid, null: false, foreign_key: true
      t.references :categories, type: :uuid, null: false, foreign_key: true
    end
  end
end
