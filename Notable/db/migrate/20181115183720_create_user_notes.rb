class CreateUserNotes < ActiveRecord::Migration
  def change
    create_table :user_notes do |t|
      t.integer :user_id
      t.integer :note_id
      t.boolean :is_favorite

      t.timestamps null: false
    end
  end
end
