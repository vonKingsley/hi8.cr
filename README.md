# hi8.cr
# HTTP Interaction -8- Crystal Recorder

A Crystal version of the Ruby HTTP interaction library [vcr](https://github.com/vcr/vcr).
Record your test suite's HTTP interactions and replay them during future
test runs for fast, deterministic, accurate tests.

## What's Not Included
Lots. But the main ones right now are - only recording once, then
everything is a replay unless the files are deleted. TODO: I'd like to
add a timer class to manage replays and replay intervals.


## Installation


```yaml
development_dependencies:
  hi8:
    github: vonkingsley/hi8.cr
```


## Usage
### Configure HI8
```crystal
HI8.configure do |config|
  config.cabinet_shelf = "./test_dir/cassettes"
end
```

#### Custom playback definition

You can define a custom playback behaviour by setting the `on_playback` block in the configuration. This can be necessary if you don't want to match against request headers for example. A basic definition for [`WebMock`](https://github.com/manastech/webmock.cr) could look like this:

```crystal
HI8.configure do |config|
  config.on_playback do |recorder, request, response|
    uri = URI.parse(request.uri)
    query = uri.query.to_s
    uri.query = ""
    req_headers = recorder.headers_from_hash(request.headers)
    req_query = HTTP::Params.try(&.parse(query)).to_h
    res_status = response.status.to_i
    res_headers = recorder.headers_from_hash(response.headers)

    ::WebMock.stub(request.method, uri.to_s)
             .with(query: req_query)
             .to_return(status: res_status, body: response.body, headers: res_headers)
  end
end
```

### Options for each Cassette
Cassette options are a `Hash(Symbol, Symbol)`
you can pass the options in the `HI8.use_cassette` call

defaults are:
```crystal
{
  :record_mode => :once,
  :record_with => :webmock,
  :store_with  => :file_system,
  :format_with => :yaml
}
```

### Usage
```crystal
HI8.use_cassette("cassette_name") do
  ...
end
```
## Development
I probably take the whole Cassette emulation a little to far, but its fun.
We have **Cassettes** which manage the playback and recording of episodes.

An **Episode** is an HTTP interaction.

**StorageCabinets** are where the cassettes are stored. Currently we only
have the file system.

**Formats** are how the episode is stored on in the `StorageCabinet`.
Currently we support YAML && JSON.

**RecordingLibaries** are the Mocking libraries. Currently we only
support [WebMock](https://github.com/manastech/webmock.cr)


## Contributing

1. Fork it ( https://github.com/vonkingsley/hi8/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [vonkingsley](https://github.com/vonkingsley) Kingsley Lewis - creator, maintainer
- [alexanderadam](https://github.com/alexanderadam) Alexander Adam - likes the smell of video cassettes

## Kudos
Myron Marston and all the [contributers](https://github.com/vcr/vcr#credits) of the original VCR
