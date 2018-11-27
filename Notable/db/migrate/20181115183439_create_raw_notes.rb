class CreateRawNotes < ActiveRecord::Migration
  def change
    create_table :raw_notes do |t|
      t.string :raw_content
      t.string :attached_files

      t.timestamps null: false
    end
  end
end
