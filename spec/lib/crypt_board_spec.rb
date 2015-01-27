require "spec_helper"
require "crypt_board"

describe CryptBoard do

	let(:crypt_board) { CryptBoard.new('PLAYFAIRCYPHER') }
	let(:input) { Input.new( 'data/crypt_data.txt', crypt_board ) }

	it "should be created by the Input object in this application" do
		expect( input.file_target_object ).to be_kind_of (CryptBoard)
	end

	it "should respond to convert_data call via the Input object" do
		expect( crypt_board ).to respond_to(:convert_data)
	end

	it "should contain an array with five cells which is the first row" do
		expect( crypt_board.lookup_char_array ).to be_kind_of (Array)
		expect( crypt_board.lookup_char_array.length ).to be == 5
	end

	it "should have an array of five cells in each cell of the main array which build up the next four rows" do
		crypt_board.lookup_char_array.each do |column|
			expect( column ).to be_kind_of (Array)
			expect( column.length ).to be == 5
		end
	end

	it "should have characters at the expected positions in the array" do
		expect( crypt_board.lookup_char_array[0][0] ).to be =='P'
		expect( crypt_board.lookup_char_array[0][1] ).to be =='L'
		expect( crypt_board.lookup_char_array[0][4] ).to be =='F'

		expect( crypt_board.lookup_char_array[2][2] ).to be =='G'

		expect( crypt_board.lookup_char_array[4][0] ).to be =='U'
		expect( crypt_board.lookup_char_array[4][3] ).to be =='X'
		expect( crypt_board.lookup_char_array[4][4] ).to be =='Z'
	end

	it "should get the position of a character in the array" do
		expect( crypt_board.lookup_position_array['P'] ).to be == { :row => 0, :col => 0 }
		expect( crypt_board.lookup_position_array['L'] ).to be == { :row => 0, :col => 1 }
		expect( crypt_board.lookup_position_array['F'] ).to be == { :row => 0, :col => 4 }

		expect( crypt_board.lookup_position_array['G'] ).to be == { :row => 2, :col => 2 }

		expect( crypt_board.lookup_position_array['U'] ).to be == { :row => 4, :col => 0 }
		expect( crypt_board.lookup_position_array['X'] ).to be == { :row => 4, :col => 3 }
		expect( crypt_board.lookup_position_array['Z'] ).to be == { :row => 4, :col => 4 }
	end

	it "should have unique letter entries in each of the 25 cells" do
		expect( crypt_board.full_key.chars.to_a.uniq.length ).to be == 25
	end

	it "should have a string containing the crypt key" do
		expect( crypt_board.crypt_key ).to be_kind_of (String)
	end

	it "should contain the characters of the crypt key in order with duplicates removed" do
		expect( crypt_board.full_key ).to be == 'PLAYFIRCHEBDGJKMNOSTUVWXZ'
	end

	# PLAYF
	# IRCHE
	# BDGJK
	# MNOST
	# UVWXZ

	context "function that retrieves characters from any given direction" do 
		it "gets the character from the next cell" do
			expect( crypt_board.get_char(3,2,:up) ).to be == 'G'
			expect( crypt_board.get_char(3,2,:down) ).to be == 'W'
			expect( crypt_board.get_char(3,2,:left) ).to be == 'N'
			expect( crypt_board.get_char(3,2,:right) ).to be == 'S'
		end
		it "gets the character from the first cell if it points at the last cell" do
			expect( crypt_board.get_char(0,0,:up) ).to be == 'U'
			expect( crypt_board.get_char(4,4,:down) ).to be == 'F'
			expect( crypt_board.get_char(0,0,:left) ).to be == 'F'
			expect( crypt_board.get_char(4,4,:right) ).to be == 'U'
		end
	end

	context "function that retrieves characters from opposite corners of a box" do

	end

end