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

	# performs string manipulation before the pairing stage, leaving us with just letters
	# and ensuring the string has an even number of chars
	def prepare_for_pairing
		@message = @message.gsub(/\p{^Alnum}/, '')
		@message += 'Z' if @message.length % 2 == 1
	end

	# converts a string to an array of pairs
	def to_pair_array(string)
		string.chars.to_a.in_groups_of(2)
	end

	# takes a pair of chars and either encrypts or decrypts them
	#
	# first & second are the characters, for retrieving positions
	# method :encrypt or :decrypt, used to tell the method which way to look at the crypt board
	def convert_pair(first,second,method)
		pos1 = @crypt_key.position_array[first]
		pos2 = @crypt_key.position_array[second]

		row_direction = method == :encrypt ? :right : :left
		col_direction = method == :encrypt ? :down : :up

		position_relationship = get_position_relationship pos1, pos2

		case position_relationship
		when :row
			pair_characters([pos1[:row], pos1[:col]], [pos2[:row], pos2[:col]], row_direction)
		when :col
			pair_characters([pos1[:row], pos1[:col]], [pos2[:row], pos2[:col]], col_direction)
		when :box
			pair_characters([pos1[:row], pos2[:col]], [pos2[:row], pos1[:col]])
		end
	end

	def pair_characters(chars1, chars2, direction = nil)
		[ @crypt_key.get_char(*chars1, direction),
			@crypt_key.get_char(*chars2, direction) ]
	end

	# gets the relationshiop between the positions of two cells, :row, :col or :box
	def get_position_relationship(pos1,pos2)
		return :row if pos1[:row] == pos2[:row]
		return :col if pos1[:col] == pos2[:col]
		return :box
	end

	# encrypts the full message
	def encrypt_message
		@encrypted_pairs = []
		prepare_for_pairing
		to_pair_array(@message).each do |pair|
			pair[1] = 'Q' if pair[0] == pair[1]
			@encrypted_pairs << convert_pair(pair[0],pair[1],:encrypt)
		end
		@encrypted = @encrypted_pairs.join('')
	end

	# decrypts the full message
	def decrypt_message
		@decrypted_pairs = []
		to_pair_array(@encrypted).each do |pair|
			@decrypted_pairs << convert_pair(pair[0],pair[1],:decrypt)
		end
		@decrypted = @decrypted_pairs.join('')
	end

end
