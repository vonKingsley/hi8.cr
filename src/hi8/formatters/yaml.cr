require "yaml"

class Request
  include YAML::Serializable

  property method : String
  property uri : String
  property body : String
  property headers : Hash(String, String)
end

class Response
  include YAML::Serializable

  property status : String
  property headers : Hash(String, String)
  property body : String
  property http_version : String
end

class Episode
  include YAML::Serializable

  property request : Request
  property response : Response
end

class Episodes
  include YAML::Serializable

  property episodes : Array(Episode)
  property recorded_with : String
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
