class Note < ActiveRecord::Base
	has_many :task, :raw_note, :review_chunk
	belongs_to :user_note
end
