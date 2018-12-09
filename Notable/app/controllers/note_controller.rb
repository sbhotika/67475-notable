class NoteController < ApplicationController
	def index
	end

	def create
		@note = Note.new
	end



end