require "./recording_libraries/library"

module HI8
  # Keeps track of the recording libraries
  # put new libraries in the recording_libraries directory
  class Recorder(Library)

    getter libraries

    def initialize
      @libraries = {} of Symbol => Library
    end

    # Gets the named cabinet.
    #
    # @param name [Symbol] the name of the cabinet
    # @return the named cabinet
    # @raise if there is not a cabinet for the given name
    def [](name)
      @libraries.fetch(name) do
        @libraries[name] = case name
                          when :webmock then HI8::Library::WebMock.new
                          else raise "The requested HI8 library " +
                           "(#{name.inspect}) is not registered."
                          end
      end
    end

    # Registers a library.
    #
    # @param name [Symbol] the name of the library
    # @param value [#[], #[]=] the library object. It must implement `[]` and `[]=`.
    def []=(name, value)
      if @libraries.has_key?(name)
        puts "WARNING: There is already a HI8 library " +
          "registered for #{name.inspect}. Overriding it."
      end

      @libraries[name] = value
    end
  end
end
