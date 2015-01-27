require "spec_helper"
require "input"

describe Input do

	it "should read the cipher file" do

		expect( IO.read(subject.file_source).length ).to be > 0

		expect( subject.file_data ).to be_kind_of (String)

		expect( subject.file_data.length ).to be > 0

	end

	it "should create a new CryptBoard object" do

		expect( subject.file_target_object ).to be_kind_of (CryptBoard)

		expect( subject.file_target_object ).to respond_to (:convert_data)

	end

end