class Encrypter

	attr_accessor :message

	def initialize(message)
		@message = message
	end

	def process_message
		strip_spaces
		handle_odd_char_count
		make_pairs
		replace_pairs
	end

	def strip_spaces
		@message = @message.gsub(/\p{^Alnum}/, '')
	end

	def handle_odd_char_count
		if @message.length % 2 == 1
			@message += 'Z'
		end
	end

end