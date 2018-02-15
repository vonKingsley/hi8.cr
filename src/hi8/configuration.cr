require "./recording_libraries/library"

module HI8
  class Configuration
    property cabinet_shelf : String
    getter default_cassette_options
    getter playback_block : HI8::Library::PlaybackBlockType?

    def initialize
      @cabinet_shelf = "./fixtures/cassettes"
      @default_cassette_options = {
        :record_mode => :once,
        :record_with => :webmock,
        :store_with  => :file_system,
        :format_with => :yaml,
      }
    end

    def cassette_library_dir=(dir)
      puts "cassette_library_dir is deprecated use cabinet_shelf"
      @cabinet_shelf = dir
    end

    def cassette_library_dir
      puts "cassette_library_dir is deprecated use cabinet_shelf"
      @cabinet_shelf
    end

    def on_playback(&@playback_block : HI8::Library::PlaybackBlockType)
    end

    def remove_playback_block!
      @playback_block = nil if @playback_block
    end
  end
end
