class CryptBoard

	attr_accessor :char_array,
		:crypt_key,
		:full_key,
		:position_array

	CRYPT_ALPHABET = 'ABCDEFGHIKLMNOPQRSTUVWXYZ'

	def initialize (crypt_key)
		@crypt_key = crypt_key
		@full_key = (@crypt_key + CRYPT_ALPHABET).chars.to_a.uniq.join('')
		create_crypt_array
	end

	# build up the crypt board arrays, one references the char using position co-ordinates
	# the other references the position co-ordinates using the char (reverse look-up)
	def create_crypt_array
		@char_array = []
		@position_array = Hash.new
		full_key_array = @full_key.chars.to_a
		(0..4).each do |row|
			@char_array[row] = []
			(0..4).each do |col|
				char = full_key_array[(row*5) + col]
				@char_array[row][col] = char
				@position_array[char] = { :row => row, :col => col }
			end
		end
	end

	# gets the char optionsally in a certain direction, taking into account the edges of the board
	# which act cyclically
	#
	# row & col - the position co-ordinates to start from
	# direction - one of four directions, or nil if we just need the chars at a certain position
	#    this is used for getting the chars at a corner
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
		@char_array[row][col]
	end
end