# hi8.cr
#HTTP Interaction -8- Crystal Recorder

A Crystal version of the Ruby HTTP interaction library [vcr](https://github.com/vcr/vcr).
Record your test suite's HTTP interactions and replay them during future
test runs for fast, deterministic, accurate tests.

## Whats Not Included
Lots.  But the main ones right now are - only recording once, then
everything is a replay unless the files are deleted.  TOOD: I'd like to
add a timer class to manage replays and replay intervals.


## Installation


```yaml
development_dependencies:
  hi8:
    github: vonkingsley/hi8.cr
```


## Usage
###Options for each Cassette
cassette options are a Hash(Symbol, Symbol)
you can pass the options in the HI8.use_cassette call

defaults are:  
```crystal
{
  :record_mode => :once,
  :record_with => :webmock,
  :store_with  => :file_system,
  :format_with => :yaml
}
```

###Configure HI8
```crystal
HI8.configure do |config|
  config.cassette_library_dir = "./test_dir/cassettes"
end
```

###Usage
```crystal
HI8.use_cassette("cassette_name") do 
  ...
end
```
## Development
I probably take the whole Cassette emulation a little to far, but its fun.  
We have **Cassettes** which manage the playback and recording of episodes.  

An **Episode** is an http interaction.  

**StorageCabinets** are where the cassettes are stored.  Currently we only
have the file system.  

**Formats** are how the episode is stored on in the StorageCabinet.
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

##Kudos
Myron Marston and all the [contributers](https://github.com/vcr/vcr#credits) of the original VCR
