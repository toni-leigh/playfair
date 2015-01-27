class CryptBoard

	attr_accessor :crypt_array, :crypt_key, :full_key

	CRYPT_ALPHABET = 'ABCDEFGHIKLMNOPQRSTUVWXYZ'

	def initialize (crypt_key)
		@crypt_key = crypt_key
		set_full_key
		create_crypt_array
	end

	def convert_data

	end

	def set_full_key
		@full_key = (@crypt_key + CRYPT_ALPHABET).chars.to_a.uniq.join('')
	end

	def create_crypt_array
		@crypt_array = []
		full_key_array = @full_key.chars.to_a
		(0..4).each do |row|
			@crypt_array[row] = []
			(0..4).each do |col|
				@crypt_array[row][col] = full_key_array[(row*5) + col]
			end
		end
	end

end