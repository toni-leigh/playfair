class CryptBoard

	attr_accessor :crypt_key, :full_key, :lookup_char_array, :lookup_position_array

	CRYPT_ALPHABET = 'ABCDEFGHIKLMNOPQRSTUVWXYZ'

	def initialize (crypt_key)
		@crypt_key = crypt_key
		@full_key = (@crypt_key + CRYPT_ALPHABET).chars.to_a.uniq.join('')
		create_crypt_array
	end

	def create_crypt_array
		@lookup_char_array = []
		@lookup_position_array = Hash.new
		full_key_array = @full_key.chars.to_a
		(0..4).each do |row|
			@lookup_char_array[row] = []
			(0..4).each do |col|
				char = full_key_array[(row*5) + col]
				@lookup_char_array[row][col] = char
				@lookup_position_array[char] = { :row => row, :col => col }
			end
		end
	end

	def get_char(row,col,direction = nil)
		case direction
		when :up
			row == 0 ? row = 4 : row -= 1
		when :down
			row == 4 ? row = 0 : row += 1
		when :left
			col == 0 ? col = 4 : col -= 1
		when :right
			col == 4 ? col = 0 : col += 1
		end
		@lookup_char_array[row][col]
	end
end