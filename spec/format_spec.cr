require "./spec_helper"
describe HI8::Format do

  it "takes a Formatter" do
    json_format = HI8::Formatter::JSON.new
    format = HI8::Format(HI8::Formatter).new
    format[:json] = json_format
    format[:json].should be_a(HI8::Formatter::JSON)
  end

  it "loads multiple formatters" do
    json_format = HI8::Formatter::JSON.new
    yaml_format = HI8::Formatter::YAML.new
    format = HI8::Format(HI8::Formatter).new
    format[:json] = json_format
    format[:yaml] = yaml_format
    format[:json].should be_a HI8::Formatter::JSON
    format[:yaml].should be_a HI8::Formatter::YAML
  end

end
