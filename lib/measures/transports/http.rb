require "faraday"
require "faraday_middleware"
require "uri"

module Measures
  module Transports
    class HTTP
      def initialize(host, port = 80, url = "/", open_timeout = 30, timeout = 30)
        @host = host
        @port = port
        @url = url
        @open_timeout = open_timeout
        @timeout = timeout
      end

      def send(data)
        client.post do |req|
          req.url @url
          req.headers["Content-Type"] = "application/json"
          req.body = data
        end
      end

      def client
        Faraday.new(url: URI::HTTP.build(host: @host, port: @port)) do |c|
          c.request :json

          c.options[:open_timeout] = @open_timeout
          c.options[:timeout] = @timeout

          c.response :raise_error
          c.adapter Faraday.default_adapter
        end
      end
    end
  end
end
