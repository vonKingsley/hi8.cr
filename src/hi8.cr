require "./hi8/*"

module HI8
  extend self

  # The main configuration block
  def configure
    yield configuration
  end

  def configuration
    @@configuration ||= Configuration.new
  end

  def cassettes
    @@cassettes ||= Array(Cassette).new
  end

  def current_cassette
    cassettes.last
  end

  # This is the main entrypoint for Hi8.cr
  # Call this with a block to record your HTTP interactions
  def use_cassette(name, options = nil)
    cassette = insert_cassette(name, options)
    begin
      yield cassette
    ensure
      eject_cassette
    end
  end

  def insert_cassette(name, options)
    # if turned_on?
    #  if cassettes.any? {|c| c.name = name }
    #    raise ArgumentError.new("The cassette #{name} already exisits")
    #  end
    cassette = Cassette.new(name, options)
    cassettes << cassette
  end

  def eject_cassette
    current_cassette.record
  end

  def record_to_cassette(http_interaction)
    current_cassette.add_episode(http_interaction)
  end

  def recorders
    @@libraries ||= Recorder(Library).new
  end

  def storage
    @@cabinets ||= Storage(Cabinet).new
  end

  def formats
    @@formatters ||= Format(Formatter).new
  end

  def version
    HI8::VERSION
  end
end
