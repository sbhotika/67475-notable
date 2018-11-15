class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.int :owner_id
      t.string :title

      t.timestamps null: false
    end
  end
end
