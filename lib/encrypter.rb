require 'active_support/all'

class Encrypter

	attr_accessor :message, :message_as_pairs

	def initialize(message)
		@message = message
	end

	def process_message
		strip_spaces
		handle_odd_char_count
		make_pairs
	end

	def strip_spaces
		@message = @message.gsub(/\p{^Alnum}/, '')
	end

	def handle_odd_char_count
		if @message.length % 2 == 1
			@message += 'Z'
		end
	end

	def make_pairs
		@message_as_pairs = message.chars.to_a.in_groups_of(2)
		@message_as_pairs.each_with_index do |pair,index|
			if (pair[0] == pair[1])
				message_as_pairs[index][1] = 'Q'
			end
		end
		@message = @message_as_pairs.join('')
	end

end