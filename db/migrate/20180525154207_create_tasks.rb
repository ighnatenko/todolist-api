class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.integer :index, null: false
      t.boolean :done, default: false
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end