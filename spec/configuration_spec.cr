describe HI8::Configuration do
  it "has a default library dir" do
    HI8::Configuration.new.cassette_library_dir.should eq "./fixtures/cassettes"
  end

  it "stores default cassette options" do
    HI8::Configuration.new.default_cassette_options[:store_with].should eq :file_system
  end
end
