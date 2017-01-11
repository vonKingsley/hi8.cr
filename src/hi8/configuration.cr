module HI8
  class Configuration
    property cassette_library_dir : String
    getter default_cassette_options

    def initialize
      @cassette_library_dir = "./fixtures/cassettes"
      @default_cassette_options = {
        :record_mode => :once,
        :record_with => :webmock,
        :store_with  => :file_system,
        :format_with => :yaml,
      }
    end

    def default_cassette_options=(opts)
      @default_cassette_options.merge!(opts)
    end
  end
end
