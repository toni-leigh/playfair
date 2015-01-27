class Encrypter

	attr_accessor :message

	def initialize(message)
		@message = message
		@message = strip_spaces
	end

	def strip_spaces
		@message.gsub(/\p{^Alnum}/, '')
	end

end