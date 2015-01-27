class CryptBoard

	attr_accessor :crypt_array, :crypt_key, :prepared_crypt_key

	def initialize (crypt_key)
		@crypt_key = crypt_key
		remove_key_duplicates
		create_crypt_array
	end

	def convert_data

	end

	def remove_key_duplicates
		@prepared_crypt_key = @crypt_key.chars.to_a.uniq.join('')
	end

	def create_crypt_array
		@crypt_array = []
		(0..4).each do |row|
			@crypt_array[row] = []
			(0..4).each do |col|
				@crypt_array[row][col] = ''
			end
		end
	end

end