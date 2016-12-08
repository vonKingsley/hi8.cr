require "uri"
require "webmock"

module HI8
  module Library
    class WebMock
      include Library

      def initialize
      end

      def hi8_request
        @hi8_request ||= ""
      end

      def playback
        ::WebMock.allow_net_connect = false
      end

      def record
        ::WebMock.allow_net_connect = true
      end

      def recording?
        ::WebMock.allows_net_connect?
      end

      def playback_episode(request, response)
        uri = uri_parse(request.uri)
        method      = request.method
        url         = url_builder(uri)
        req_body    = request.body
        req_headers = headers_from_hash(request.headers)
        req_query   = HTTP::Params.try(&.parse(uri.query.to_s)).to_h
        res_status  = response.status.to_i
        res_body    = response.body
        res_headers = headers_from_hash(response.headers)

        if req_body.empty?
          ::WebMock.stub(method, url)
            .with(headers: req_headers, query: req_query)
            .to_return(status: res_status, body: res_body, headers: res_headers)
        else
          ::WebMock.stub(method, url)
            .with(headers: req_headers, body: req_body, query: req_query)
            .to_return(status: res_status, body: res_body, headers: res_headers)
        end
      end

      private def uri_parse(resource)
        URI.parse(resource)
      end

      private def url_builder(uri)
        String.build do |str|
          str << uri.scheme
          str << "://"
          str << uri.host
          str << ":" + uri.port.to_s if uri.port
          str << uri.path
        end
      end

      def headers_from_hash(headers)
        header = HTTP::Headers.new
        return header if headers.nil?
        headers.each do |key, val|
          next if (key == "User-agent" && val == "Crystal") # the Crystal user agent doesn't actually get added until later
          header.add(key.as(String), val.as(String))
        end
        header
      end

      ::WebMock.callbacks.add do
        after_live_request do |request, response|
          episode = HI8::Episode.new(request,response)
          HI8.record_to_cassette(episode)
        end
      end
    end
  end
end
