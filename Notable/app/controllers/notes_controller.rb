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

		# meeting details
		@start_time = params[:startTime]
		@end_time = params[:endTime]
		@duration = params[:diffHours] + " Hours, " +  params[:diffMins] + " Minutes, " + params[:diffSecs] + " Seconds"

		@subject = get_subject(line_buffer)

		puts "Subject: " + @subject

		@participants = get_people(line_buffer)

		puts "People: " + @participants.join("', '")

		@tasks = get_tasks(line_buffer)

		puts "Tasks: \n- " + @tasks.join("\n- ")




		respond_to do |format|
        format.js
    end
	end

	def new
 	end

	private

	def get_tasks(buffer)
		tasks = []
		keywords = /task|tasks/
		buffer.each do |line|
			words = line.split(/[.?\s,]/)
			# try to find the target word
			words.each do |word|
				if (keywords.match(word))
					puts "Found task!: " + line
					tasks << parse_task_line(line)
				end
			end
		end
		return tasks
	end



	def split_by_lines(raw_buffer)
		return raw_buffer.split(/$\n\n^/)
	end

	def get_subject(buffer)
		keyword = /about|About/
		# go through all lines
		buffer.each do |line|
			words = line.split(/[.?\s,]/)
			# try to find the target word
			words.each do |word|
				if (keyword.match(word))
					puts "Found about!: " + word
					return parse_subject_line(line)
				end
			end
		end
	end

	# precondition = has to have the keyword
	def parse_task_line(line)
		keyword = "task is to"
		lowercase_line = (line.to_str.downcase)

		# based on keyword, begin the topic substring retrieval
		start_index = lowercase_line.index(keyword) + keyword.length + 1 # add one to get first word

		end_of_line = lowercase_line.length

		puts lowercase_line[start_index..end_of_line]

		# get end of topic by finding the next period/end
		end_index = start_index + lowercase_line[start_index..end_of_line].index(/[,.]/) - 1

		puts "task: " + lowercase_line[start_index..end_index].capitalize

		return lowercase_line[start_index..end_index].capitalize
	end

	# precondition = has to have the keyword
	def parse_subject_line(line)
		keyword = "about"
		lowercase_line = (line.to_str.downcase)

		# based on keyword, begin the topic substring retrieval
		start_index = lowercase_line.index(keyword) + keyword.length + 1 # add one to get first word

		end_of_line = lowercase_line.length

		puts "nice"
		puts lowercase_line[start_index..end_of_line]

		# get end of topic by finding the next period/end
		end_index = start_index + lowercase_line[start_index..end_of_line].index(".") - 1

		return lowercase_line[start_index..end_index].capitalize

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
