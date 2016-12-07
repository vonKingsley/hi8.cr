require "yaml"

class Request
  YAML.mapping(
    method: String,
    uri: String,
    body: String,
    headers: Hash(String, String)
  )
end

class Response
  YAML.mapping(
    status: String,
    headers: Hash(String, String),
    body: String,
    http_version: String
  )
end

class Episode
  YAML.mapping(
    request: Request,
    response: Response
  )
end

class Episodes
  YAML.mapping(
    episodes: Array(Episode),
    recorded_with: String
  )
end

module HI8
  module Formatter
    class YAML
      include Formatter

      def file_extension
        "yml"
      end

      def serialize(hash)
        hash.to_yaml
      end

      def deserialize(string)
        Episodes.from_yaml(string)
      end
    end
  end
end
