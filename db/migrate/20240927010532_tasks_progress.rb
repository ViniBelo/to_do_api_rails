class TasksProgress < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks_progresses, id: :uuid do |t|
      t.references :tasks, type: :uuid, null: false, foreign_key: true
      t.references :progress, type: :uuid, null: false, foreign_key: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
