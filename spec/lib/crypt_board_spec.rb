require "spec_helper"
require "crypt_board"

describe CryptBoard do

	let(:crypt_board) { CryptBoard.new }

	let(:input) { Input.new( 'data/crypt_data.txt', crypt_board ) }

	it "should be created by the Input object in this application" do

		expect( input.file_target_object ).to be_kind_of (CryptBoard)

	end

	it "should respond to convert_data call via the Input object" do

		expect( crypt_board ).to respond_to(:convert_data)

	end

	it "should contain an array with five cells which is the first row" do

	end

	it "should have an array of five cells in each cell of the main array which build up the next four rows" do

	end

	it "should have unique letter entries in each of the 25 cells" do

	end

	it "should have a string containing the crypt key" do

	end

	it "should contain the characters of the crypt key in order with duplicates removed" do

	end

end