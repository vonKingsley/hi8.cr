require "./*"

module HI8
  module Formatter
    abstract def serialize(hash)
    abstract def deserialize(string)
    abstract def file_extension
  end
end
