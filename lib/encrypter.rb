require 'active_support/all'

class Encrypter

	attr_accessor :crypt_key,
		:decrypted,
		:encrypted,
		:message

	def initialize(message,crypt_key,input)
		@message = message
		@crypt_key = crypt_key
		@input = input
	end

	def prepare_for_pairing
		@message = @message.gsub(/\p{^Alnum}/, '')
		if @message.length % 2 == 1
			@message += 'Z'
		end
	end

	def to_pair_array(string)
		string.chars.to_a.in_groups_of(2)
	end

	def encrypt_pair(first,second,encrypt = true)
		first_position = @crypt_key.lookup_position_array[first]
		second_position = @crypt_key.lookup_position_array[second]

		row_direction = encrypt ? :right : :left
		col_direction = encrypt ? :down : :up

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
		prepare_for_pairing
		to_pair_array(@message).each do |pair|
			if (pair[0] == pair[1])
				pair[1] = 'Q'
			end
			@encrypted_pairs << encrypt_pair(pair[0],pair[1])
		end
		@encrypted = @encrypted_pairs.join('')
	end

	def decrypt_message
		@decrypted_pairs = []
		to_pair_array(@encrypted).each do |pair|
			@decrypted_pairs << encrypt_pair(pair[0],pair[1],false)
		end
		@decrypted = @decrypted_pairs.join('')
	end

end