require "spec_helper"
require "encrypter"

describe Encrypter do

	let(:encrypter) { Encrypter.new('THIS IS A TEST MESSAGE - THIS TEST MESSAGE MUST BE ENCRYPTED CAREFULLY', CryptBoard.new('PLAYFAIRCYPHER')) }
	let(:input) { Input.new( 'data/crypt_data.txt', encrypter ) }

	it "should be created by the Input object in this application" do
		expect( input.file_target_object ).to be_kind_of (Encrypter)
	end

	it "should respond to convert_data call via the Input object" do
		expect( encrypter ).to respond_to(:convert_data)
	end

	it "should store the unencrypted message" do
		expect( encrypter.message ).to be_kind_of (String)
		expect( encrypter.message.length ).to be > 0
	end

	context "Boxes - functionality identical whether encrypting or decrypting" do

		it "should replace any two characters on the corners of squares where both dimensions are at least 2 with the characters from the opposite corners - character rows must be kept in the same order" do
			expect( encrypter.encrypt_pair('R','X') ).to be == ['H','V']
			expect( encrypter.encrypt_pair('V','Y') ).to be == ['X','L']
		end

	end

	context "Encrypting" do		

		it "should strip the spaces" do
			encrypter.strip_spaces
			expect( encrypter.message ).to be == 'THISISATESTMESSAGETHISTESTMESSAGEMUSTBEENCRYPTEDCAREFULLY'
		end

		it "should append a 'Z' if it's got an odd number of chars" do
			encrypter.strip_spaces
			encrypter.handle_odd_char_count
			expect( encrypter.message ).to be == 'THISISATESTMESSAGETHISTESTMESSAGEMUSTBEENCRYPTEDCAREFULLYZ'
		end

		it "should replace any pair of equal characters in the message with the string <char1><q>" do
			encrypter.strip_spaces
			encrypter.handle_odd_char_count
			encrypter.make_pairs
			expect( encrypter.message ).to be == 'THISISATESTMESSAGETHISTESTMESQAGEMUSTBEQNCRYPTEDCAREFULQYZ'
		end

		context "Rows and columns" do

			it "should replace a pair of characters in the same row with the characters one cell to the right" do
				expect( encrypter.encrypt_pair('P','L') ).to be == ['L','A']
			end

			it "should replace the character in cell five with the character in cell one of the same row" do
				expect( encrypter.encrypt_pair('A','F') ).to be == ['F','P']
			end

			it "should replace a pair of characters in the same column with the characters one cell down" do
				expect( encrypter.encrypt_pair('D','N') ).to be == ['N','V']
			end

			it "should replace the character in cell five with the character in cell one of the same column" do
				expect( encrypter.encrypt_pair('S','X') ).to be == ['X','Y']
			end

		end

	end

	context "Decrypting" do

		it "should replace any three character strings where 1 and 3 are the same and 2 is a 'q' with just characters 1 and 3" do

		end

		context "Rows and columns" do

			it "should replace a pair of characters in the same row with the characters one cell to the left" do
				expect( encrypter.encrypt_pair('L','A') ).to be == ['P','L']
			end

			it "should replace the character in cell one with the character in cell five of the same row" do
				expect( encrypter.encrypt_pair('F','P') ).to be == ['A','F']
			end

			it "should replace a pair of characters in the same column with the characters one cell down" do
				expect( encrypter.encrypt_pair('N','V') ).to be == ['D','N']
			end

			it "should replace the character in cell one with the character in cell five of the same column" do
				expect( encrypter.encrypt_pair('X','Y') ).to be == ['S','X']
			end

		end

		it "should store the unencrypted message" do

		end

	end

end