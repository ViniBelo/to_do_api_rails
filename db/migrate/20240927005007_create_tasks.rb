class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.references :context, type: :uuid, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
