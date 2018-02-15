require "./*"

module HI8
  module Library
    alias PlaybackBlockType = (HI8::Library, ::Request, ::Response) -> Nil
    playback_block : PlaybackBlockType?

    abstract def hi8_request

    def on_playback(&@playback_block : PlaybackBlockType)
    end

    def remove_playback_block!
      @playback_block = nil if @playback_block
    end
  end
end
