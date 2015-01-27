require "spec_helper"
require "encrypter"

describe Encrypter do

	let(:encrypter) { Encrypter.new('THIS IS A TEST MESSAGE - THIS TEST MESSAGE MUST BE ENCRYPTED NICELY') }

	it "should store the unencrypted message" do
		expect( encrypter.unencrypted ).to be_kind_of (String)
		expect( encrypter.unencrypted.length ).to be > 0
	end

	context "Boxes - functionality identical whether encrypting or decrypting" do

		it "should replace the first character in the pair with the character in the same row but in the column of it's partner" do

		end

		it "should replace the second character in the pair with the character in the same row but in the column of it's partner" do

		end

	end

	context "Encrypting" do		

		it "should strip the spaces" do
			expect( encrypter.encrypted ).to be == 'THISISATESTMESSAGETHISTESTMESSAGEMUSTBEENCRYPTEDNICELY'
		end

		# used 'q' as the unusual monograph as there are quite a few ee's and exe's
		it "should replace any pair of equal characters in the message with the string <char1><q><char2>" do

		end

		context "Rows and columns" do

			it "should replace a pair of characters in the same row with the characters one cell to the right" do

			end

			it "should replace the character in cell five with the character in cell one of the same row" do

			end

			it "should replace a pair of characters in the same column with the characters one cell down" do

			end

			it "should replace the character in cell five with the character in cell one of the same column" do

			end

		end

	end

	context "Decrypting" do

		it "should replace any three character strings where 1 and 3 are the same and 2 is a 'q' with just characters 1 and 3" do

		end

		context "Rows and columns" do

			it "should replace a pair of characters in the same row with the characters one cell to the left" do

			end

			it "should replace the character in cell one with the character in cell five of the same row" do

			end

			it "should replace a pair of characters in the same column with the characters one cell down" do

			end

			it "should replace the character in cell one with the character in cell five of the same column" do

			end

		end

		it "should store the unencrypted message" do

		end

	end

end