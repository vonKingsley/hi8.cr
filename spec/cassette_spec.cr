require "./spec_helper"
describe HI8::Cassette do
  it "takes a name" do
    cassete = HI8::Cassette.new("test")
    cassete.name.should be "test"
  end

  it "accepts options" do
    cassete = HI8::Cassette.new("The Dark Crystal", {record_mode: :none}.to_h)
    cassete.name.should be "The Dark Crystal"
    cassete.record_mode.should eq(:none)
  end
end
