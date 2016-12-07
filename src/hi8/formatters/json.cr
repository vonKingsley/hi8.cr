require "json"

class Request
  JSON.mapping(
    method: String,
    uri: String,
    body: String,
    headers: Hash(String, String)
  )
end

class Response
  JSON.mapping(
    status: String,
    headers: Hash(String, String),
    body: String,
    http_version: String
  )
end

class Episode
  JSON.mapping(
    request: Request,
    response: Response
  )
end

class Episodes
  JSON.mapping(
    episodes: Array(Episode),
    recorded_with: String
  )
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

      def deserialize(string : String)
        if string
          Episodes.from_json(string)
        end
      end
    end
  end
end
