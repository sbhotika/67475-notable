class UserNote < ActiveRecord::Base
	belongs_to :user
	has_many :note
end
