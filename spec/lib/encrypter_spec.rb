require "spec_helper"
require "encrypter"

describe Encrypter do

	let(:encrypter) { Encrypter.new('THIS IS A TEST MESSAGE - THIS TEST MESSAGE MUST BE ENCRYPTED CAREFULLY', CryptBoard.new('PLAYFAIRCYPHER'), Input.new( 'data/crypt_data.txt' )) }

	it "should store the unencrypted message" do
		expect( encrypter.message ).to be_kind_of (String)
		expect( encrypter.message.length ).to be > 0
	end

	def encrypt_and_decrypt
		encrypter.encrypt_message
		encrypter.decrypt_message
	end

	context "Boxes - functionality identical whether encrypting or decrypting" do
		it "should replace any two characters on the corners of squares where both dimensions are at least 2 with the characters from the opposite corners - character rows must be kept in the same order" do
			expect( encrypter.convert_pair('R','X',:encrypt) ).to be == ['H','V']
			expect( encrypter.convert_pair('V','Y',:decrypt) ).to be == ['X','L']
			expect( encrypter.convert_pair('Z','P',:encrypt) ).to be == ['U','F']
			expect( encrypter.convert_pair('D','Q',:decrypt) ).to be == ['G','O']
			expect( encrypter.convert_pair('B','T',:encrypt) ).to be == ['M','N']
			expect( encrypter.convert_pair('A','X',:decrypt) ).to be == ['Y','W']
		end
	end

	context "Encrypting" do
		it "should strip the spaces and should append a 'Z' if it's got an odd number of chars" do
			encrypt_and_decrypt
			expect( encrypter.message ).to be == 'THISISATESTMESSAGETHISTESTMESSAGEMUSTBEENCRYPTEDCAREFULLYZ'
		end
		it "should replace any pair of equal characters in the message with the string <char1><q>" do
			encrypt_and_decrypt
			expect( encrypter.decrypted ).to be == 'THISISATESTMESSAGETHISTESTMESQAGEMUSTBEQNCRYPTEDCAREFULQYZ'
		end
		context "Rows and columns" do
			it "should replace a pair of characters in the same row with the characters one cell to the right" do
				expect( encrypter.convert_pair('P','L',:encrypt) ).to be == ['L','A']
			end
			it "should replace the character in cell five with the character in cell one of the same row" do
				expect( encrypter.convert_pair('Y','F',:encrypt) ).to be == ['F','P']
			end
			it "should replace a pair of characters in the same column with the characters one cell down" do
				expect( encrypter.convert_pair('D','O',:encrypt) ).to be == ['O','V']
			end
			it "should replace the character in cell five with the character in cell one of the same column" do
				expect( encrypter.convert_pair('S','X',:encrypt) ).to be == ['X','Y']
			end
		end
		it "should create an encrypted message" do
			encrypter.encrypt_message
			expect( encrypter.encrypted ).to be == 'SEHNHNFQHTZTHTQYMCSEHNZMTNTMTSCQMTXNNMCTQIHLFNRMGCCIPZAOFX'
		end
	end

	context "Decrypting" do
		context "Rows and columns" do
			it "should replace a pair of characters in the same row with the characters one cell to the left" do
				expect( encrypter.convert_pair('L','A',:decrypt) ).to be == ['P','L']
			end
			it "should replace the character in cell one with the character in cell five of the same row" do
				expect( encrypter.convert_pair('F','P',:decrypt) ).to be == ['Y','F']
			end
			it "should replace a pair of characters in the same column with the characters one cell down" do
				expect( encrypter.convert_pair('O','V',:decrypt) ).to be == ['D','O']
			end
			it "should replace the character in cell one with the character in cell five of the same column" do
				expect( encrypter.convert_pair('X','Y',:decrypt) ).to be == ['S','X']
			end
		end
		it "should store the unencrypted message" do
			encrypt_and_decrypt
			expect( encrypter.decrypted ).to be == 'THISISATESTMESSAGETHISTESTMESQAGEMUSTBEQNCRYPTEDCAREFULQYZ'
		end
	end
	
end