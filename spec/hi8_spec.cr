require "./spec_helper"
require "file_utils"

Spec.after_each do
  dir = HI8.configuration.cassette_library_dir
  match = dir.match(/(\.\/.*)\//)
  if match
    del_dir = match[0]
    FileUtils.rm_r(del_dir) if Dir.exists?(del_dir)
  end
end

describe HI8 do

  it "takes a configuration block" do
    HI8.configure do |config|
      config.cassette_library_dir = "./test_dir/cassettes"
    end
    HI8.configuration.cassette_library_dir.should eq "./test_dir/cassettes"
  end

  it "takes a use_cassette block" do
    HI8.use_cassette("tester_mctesterson") do
      request = HTTP::Client.get "http://www.example.net"
      request.status_code.should eq 200
      request.body.should contain "Example Domain"
    end
  end

  it "accepts multiple requests in a single use_cassette" do
    HI8.use_cassette("double_mctesterson") do
      req1 = HTTP::Client.get "http://www.example.net"
      req1.status_code.should eq 200
      req1.body.should contain "Example Domain"
      req2 = HTTP::Client.get "http://google.com"
      req2.body.should contain "google"
    end
  end

  it "works with a json formtter" do
    HI8.use_cassette("json_mctesterson", {:format_with => :json}) do
      request = HTTP::Client.get "http://www.example.net"
      request.body.should contain "Example Domain"
      request.status_code.should eq 200
    end
    File.exists?(HI8.configuration.cassette_library_dir + "/json_mctesterson.json").should be_true
  end

  it "replays a cassette" do
    HI8.use_cassette("replay_mctesterson") do
      HI8.current_cassette.recorder.recording?.should be_true
      request = HTTP::Client.get "http://www.example.net"
      request.status_code.should eq 200
      request.body.should contain "Example Domain"
    end
    HI8.use_cassette("replay_mctesterson") do
      HI8.current_cassette.recorder.recording?.should be_false
      request = HTTP::Client.get "http://www.example.net"
      request.status_code.should eq 200
      request.body.should contain "Example Domain"
    end
  end

  it "works with query strings" do
    HI8.use_cassette("query_mcstringerson", {:format_with => :yaml}) do
      request = HTTP::Client.get "http://www.example.net/resource?test=mctesterson&query=string"
      request.status_code.should eq 404
      request.body.should contain "Example Domain"
    end
    HI8.use_cassette("query_mcstringerson") do
      request = HTTP::Client.get "http://www.example.net/resource?test=mctesterson&query=string"
      request.status_code.should eq 404
      request.body.should contain "Example Domain"
    end
  end

  it ".storage have a default of file_system" do
    HI8.storage.should be_a HI8::Storage(HI8::Cabinet)
    HI8.storage.cabinets.has_key?(:file_system).should be_true
  end

  it ".formats have a default format of yaml" do
    HI8.formats.should be_a HI8::Format(HI8::Formatter)
    HI8.formats.formatters.has_key?(:yaml).should be_true
  end

  it ".recoreders have a default recorder of webmock" do
    HI8.recorders.should be_a HI8::Recorder(HI8::Library)
    HI8.recorders.libraries.has_key?(:webmock).should be_true
  end

end
