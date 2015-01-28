require 'active_support/all'

class Encrypter

	attr_accessor :crypt_key, :encrypted_message, :message, :message_as_pairs

	def initialize(message,crypt_key)
		@message = message
		@crypt_key = crypt_key
	end

	def convert_data

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

	def encrypt_pair(first,second,encrypt = true)
		first_position = @crypt_key.lookup_position_array[first]
		second_position = @crypt_key.lookup_position_array[second]

		row_direction = encrypt == true ? :right : :left
		col_direction = encrypt == true ? :down : :up

		if (first_position[:row] != second_position[:row] &&
			first_position[:col] != second_position[:col])
			[
				@crypt_key.get_char(first_position[:row],second_position[:col]),
				@crypt_key.get_char(second_position[:row],first_position[:col])
			]
		else
			if (first_position[:row] == second_position[:row])
				[
					@crypt_key.get_char(first_position[:row],first_position[:col],row_direction),
					@crypt_key.get_char(second_position[:row],second_position[:col],row_direction)
				]
			else
				[
					@crypt_key.get_char(first_position[:row],first_position[:col],col_direction),
					@crypt_key.get_char(second_position[:row],second_position[:col],col_direction)
				]
			end
		end
	end

	def encrypt_message
		@encrypted_pairs = []
		@message_as_pairs.each do |pair|
			@encrypted_pairs << encrypt_pair(pair[0],pair[1])
		end
		@encrypted_message = @encrypted_pairs.join('')
	end

end