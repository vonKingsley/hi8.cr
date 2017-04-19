require "./storage_cabinets/cabinet"

module HI8
  # Keeps track of the cassette cabinets
  # Cabinets are where the cassettes are stored
  # this defaults to the file system
  # Put your new cabinets in the cabinets directory
  class Storage(Cabinet)
    getter cabinets

    def initialize
      @cabinets = {} of Symbol => Cabinet
    end

    # Gets the named cabinet.
    #
    # @param name [Symbol] the name of the cabinet
    # @return the named cabinet
    # @raise if there is not a cabinet for the given name
    def [](name)
      @cabinets.fetch(name) do
        @cabinets[name] = case name
                          when :file_system then HI8::Cabinet::FileSystem.new
                          else
                            raise "The requested HI8 cassette cabinet " +
                                     "(#{name.inspect}) is not registered."
                          end
      end
    end

    # Registers a persister.
    #
    # @param name [Symbol] the name of the persister
    # @param value [#[], #[]=] the persister object. It must implement `[]` and `[]=`.
    def []=(name, value)
      if @cabinets.has_key?(name)
        puts "WARNING: There is already a HI8 cassette shelf " +
             "registered for #{name.inspect}. Overriding it."
      end

      @cabinets[name] = value
    end
  end
end
