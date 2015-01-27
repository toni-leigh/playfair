class Encrypter

	attr_accessor :encrypted, :unencrypted

	def initialize(message)
		@unencrypted = message
		strip_spaces		
	end

	def strip_spaces
		@encrypted = @unencrypted.gsub(/\p{^Alnum}/, '')
	end

end