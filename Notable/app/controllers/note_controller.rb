class NoteController < ApplicationController
	def index
	end

	def create
		@note = Note.new
	end

	def transcribe
		@content = nil #this is where we call the library

	end



end