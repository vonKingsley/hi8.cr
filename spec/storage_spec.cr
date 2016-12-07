require "./spec_helper"

module HI8::Cabinet
  class TestCabinet
    include Cabinet
    def store(file_name, content); end
    def watch(file_name); end
  end
end

describe HI8::Storage do

  it "takes a cabinet" do
    fs_cabinet = HI8::Cabinet::FileSystem.new
    storage = HI8::Storage(HI8::Cabinet).new
    storage[:fs_cabinet] = fs_cabinet
    storage[:fs_cabinet].should be_a(HI8::Cabinet::FileSystem)
  end

  it "takes different types of cabinets" do
    fs_cabinet = HI8::Cabinet::FileSystem.new
    test_cabinet = HI8::Cabinet::TestCabinet.new
    storage = HI8::Storage(HI8::Cabinet).new
    storage[:fs_cabinet] = fs_cabinet
    storage[:test_cabinet] = test_cabinet
    storage[:fs_cabinet].should be_a HI8::Cabinet::FileSystem
    storage[:test_cabinet].should be_a HI8::Cabinet::TestCabinet
  end

end
