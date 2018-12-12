class NotesController < ApplicationController
	def index
	end

	def create
		@note = Note.new
	end

	def transcribe


		@raw_text = params[:rawText]
		@parsed_text = "parsed"

		puts "\n\\n\n" + params[:rawText] + "\n\n\n\n\n"

		respond_to do |format|
        format.js
    end
	end

  	def new
 	end
end
