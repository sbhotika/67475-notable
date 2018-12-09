class User < ActiveRecord::Base
	has_many :user_reminder, :user_note
end
