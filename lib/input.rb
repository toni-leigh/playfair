class Input

	attr_accessor :file_data, :file_source, :file_target_object

	def initialize (file_source = 'test.txt', file_target_object = Object.new)

		@file_source = file_source

		@file_target_object = file_target_object

		read_file

	end

	def read_file

		@file_data = IO.read(@file_source)

	end

end