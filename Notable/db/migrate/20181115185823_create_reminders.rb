class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.timestamp :utc_time
      t.text :reminder_content

      t.timestamps null: false
    end
  end
end
