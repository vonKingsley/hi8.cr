def recording_lib
  HI8::Library::WebMock.new
end

describe HI8::Library::WebMock do

  it ".record sets allows_net_connect to true" do
    recording_lib.record
    ::WebMock.allows_net_connect?.should be_true
  end

  it ".playback sets allow_net_connect to false" do
    recording_lib.playback
    ::WebMock.allows_net_connect?.should be_false
  end

  it ".recording? returns true if recording a episode" do
    recording_lib.record
    recording_lib.recording?.should be_true
  end

  it ".recording? returns false if playing back an episode" do
    recording_lib.playback
    recording_lib.recording?.should be_false
  end

  it ".playback_episode stubs a http episode" do
    episodes = HI8::Formatter::YAML.new.deserialize(File.read(ASSETS + "/fixtures/double_mctesterson.yml")).episodes
    req = episodes.first.request
    res = episodes.first.response
    recording_lib.playback_episode(req, res)
    http_req = HTTP::Request.new(req.method, "/", recording_lib.headers_from_hash(req.headers), req.body)
    ::WebMock.find_stub(http_req).should be_a WebMock::Stub
    ::WebMock.reset
  end
end
