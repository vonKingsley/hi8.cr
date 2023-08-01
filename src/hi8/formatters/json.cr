require "json"

class Request
  include JSON::Serializable

  property method : String
  property uri : String
  property body : String
  property headers : Hash(String, String)
end

class Response
  include JSON::Serializable

  property status : String
  property headers : Hash(String, String)
  property body : String
  property http_version : String
end

class Episode
  include JSON::Serializable

  property request : Request
  property response : Response
end

class Episodes
  include JSON::Serializable

  property episodes : Array(Episode)
  property recorded_with : String
end

module HI8
  module Formatter
    class JSON
      include Formatter

      def file_extension
        "json"
      end

      def serialize(hash)
        hash.to_json
      end

      def deserialize(string)
        return unless string

        Episodes.from_json(string)
      end
    end
  end
end
