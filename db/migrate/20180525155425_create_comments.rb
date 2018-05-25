class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :task, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end