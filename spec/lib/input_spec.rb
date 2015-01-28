require "spec_helper"
require "input"

describe Input do

	it "should read a file" do
		expect( IO.read(subject.file_source).length ).to be > 0
		expect( subject.file_data ).to be_kind_of (String)
		expect( subject.file_data.length ).to be > 0
	end

	it "should create a data processing object that responds to a convert_data method call" do
		expect( subject.file_target_object ).to be_kind_of (Object)
	end

end