class CreateReviewChunks < ActiveRecord::Migration
  def change
    create_table :review_chunks do |t|
      t.integer :starting_pt
      t.integer :ending_pt

      t.timestamps null: false
    end
  end
end
