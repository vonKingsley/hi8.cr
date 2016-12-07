describe HI8::Cassette do

  it "takes a name" do
    cas = HI8::Cassette.new("test")
    cas.name.should be "test"
  end

end
