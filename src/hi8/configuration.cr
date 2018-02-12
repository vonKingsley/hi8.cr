module HI8
  class Configuration
    property cabinet_shelf : String
    getter default_cassette_options

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

    #def default_cassette_options=(opts)
    #  @default_cassette_options.merge!(opts)
    #end
  end
end
