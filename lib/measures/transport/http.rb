require "faraday"
require "faraday_middleware"
require "uri"

module Measures
  module Transport
    class HTTP
      def initialize(host, port)
        @host = host
        @port = port
      end

      def send(data)
        client = Faraday.new(url: URI::HTTP.build(host: @host, port: @port)) do |c|
          c.request :json

          c.adapter Faraday.default_adapter
        end

        client.post do |req|
          req.url "/"
          req.headers["Content-Type"] = "application/json"
          req.body = data
        end
      end
    end
  end
end
