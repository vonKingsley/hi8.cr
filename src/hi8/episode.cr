# An episode is a recorded http interaction
# we create a request and response in a hash
# these are later formatted into the format
# selected in the config.
module HI8
  module HTTPHelpers
    def header_params(headers)
      header_hash = {} of String => String
      headers.each do |key, val|
        header_hash[key] = val.join("; ")
      end
      header_hash
    end

    def uri_creator(host, resources)
      resources.starts_with?(host) ? resources : host + resources
    end
  end

  class Episode
    def initialize(request : HTTP::Request, response : HTTP::Client::Response)
      @request = Request.new(request)
      @response = Response.new(response)
    end

    def to_hash
      {
        :request  => @request.to_hash,
        :response => @response.to_hash,
      } of Symbol => Hash(Symbol, String | Hash(String, String))
    end

    def from_hash(episode)
      Request.new(episode[])
    end
  end

  class Request
    include HTTPHelpers

    def initialize(@request : HTTP::Request, @uri : String? = nil)
    end

    def to_hash
      {
        :method  => @request.method.to_s,
        :uri     => uri_creator(uri_from_header.to_s, @request.resource.to_s),
        :body    => @request.body.to_s,
        :headers => header_params(@request.headers),
      } of Symbol => String | Hash(String, String)
    end

    private def uri_from_header
      "#{@request.scheme}://#{@request.headers["Host"]}" || ""
    end
  end

  class Response
    include HTTPHelpers

    def initialize(@response : HTTP::Client::Response)
    end

    def to_hash
      {
        :status       => @response.status_code.to_s,
        :headers      => header_params(@response.headers),
        :body         => @response.body.to_s,
        :http_version => @response.version,
      } of Symbol => String | Hash(String, String)
    end
  end
end
