class Encrypter

	attr_accessor :encrypted, :unencrypted

	def initialize(message)
		@unencrypted = message
		@unencrypted = strip_spaces
	end

	def strip_spaces
		@unencrypted.gsub(/\p{^Alnum}/, '')
	end

end