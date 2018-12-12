class NotesController < ApplicationController
	def index
	end

	def create
		@note = Note.new
	end


# "Good morning everybody. We’re going to have a quick meeting today about some things we have to get done this week. The first task is to figure out what the client wants from George by Friday.
# \n\nSounds good to me.
# \n\nGreat. The second task is to determine the specifications needed to deploy our test environment. Alex, does that work with you?
# \n\nThat works.
# \n\nAwesome. Finally, the third task is to schedule a time for a final round of user testing, so we need to book a room. Sally, that work?
# \n\nSure.
# \n\nThanks for coming guys. Let’s make good software.\n"


	def transcribe
		raw_text = params[:rawText]

		# each element represents the the lines that a single person speaks
		line_buffer = split_by_lines(raw_text)



		@raw_text = raw_text


		@participants = get_people(line_buffer)


		@parsed_text = "parsed"

		respond_to do |format|
        format.js
    end
	end

	def new
 	end

	private

	def split_by_lines(raw_buffer)
		return raw_buffer.split(/$\n\n^/)
	end

	def get_people(buffer)
		people = []
		known_people = ["Alec", "Alex", "George", "Sally", "Shubhangi", "Siting", "Sally"].to_set

		puts "starting word parse"
		buffer.each do |line|
			words = line.split(/[.?\s,]/)
			words.each do |word|
				if (known_people.include?(word))
					people << (word)
					puts "Person: " + word
				end
			end
		end
		return people
	end


end
