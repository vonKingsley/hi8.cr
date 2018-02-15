module HI8
  class Cassette
    # The supported record modes.
    #
    #   * :all -- Record every HTTP interactions; do not play any back.
    #   * :none -- Do not record any HTTP interactions; play them back.
    #   * :new_episodes -- Playback previously recorded HTTP interactions and record new ones.
    #   * :once -- Record the HTTP interactions if the cassette has not already been recorded;
    #              otherwise, playback the HTTP interactions.
    VALID_RECORD_MODES = [:all, :none, :new_episodes, :once]

    @options : Hash(Symbol, Symbol)
    @storage : HI8::Cabinet
    @format : HI8::Formatter
    @recorder : HI8::Library
    @record_mode : Symbol

    # the name of the cassette
    property name

    # The record mode for this cassette
    property record_mode

    getter recorder, format, storage

    def initialize(@name : String, options : Hash? = nil)
      @options = HI8.configuration.default_cassette_options
      @options.merge!(options) if options
      @record_mode = @options[:record_mode]
      @format = HI8.formats[@options[:format_with]]
      @storage = HI8.storage[@options[:store_with]]
      @recorder = HI8.recorders[@options[:record_with]]
    end

    def insert!
      playback = @storage.watch(label)
      if playback
        @recorder.playback
        recorded_episodes
      else
        @recorder.record
      end
      self
    end

    # label returns the name of the casette on disk
    def label
      [name, @format.file_extension].join('.')
    end

    def formatter_hash
      {
        :episodes      => episodes_to_record.map(&.to_hash),
        :recorded_with => "HI8.CR #{HI8.version}",
        :recorded_at   => Time.now.to_s,
      } of Symbol => String | Array(Hash(Symbol, Hash(Symbol, String | Hash(String, String))))
    end

    def episodes_to_record
      new_episodes
    end

    def add_episode(interaction)
      new_episodes << interaction
    end

    def new_episodes
      @new_episodes ||= [] of Episode
    end

    def recorded_episodes
      episodes = rewind_and_playback
      if episodes
        episodes.episodes.each do |episode|
          @recorder.playback_episode(episode.request, episode.response)
        end
      end
    end

    def record
      return if new_episodes.none?
      hash = formatter_hash
      return if hash[:episodes].as(Array).none?
      @storage.store(label, @format.serialize(hash))
    end

    def rewind_and_playback
      tape = @storage.watch(label)
      @format.deserialize(tape) if tape
    end

    private def record_date
      File.stat(label)
    end
  end
end
