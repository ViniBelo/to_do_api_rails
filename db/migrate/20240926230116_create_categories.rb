class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.references :context, type: :uuid, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :color
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
