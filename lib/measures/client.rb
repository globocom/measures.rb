require "socket"
require "json"
require "benchmark"

module Measures
  class Client
    def initialize(client, host, port)
      @client = client
      @socket = UDPSocket.new
      @socket.connect(host, port)
    end

    def count(metric, data = {})
      message = {
        "client" => @client,
        "metric" => metric,
        "count" => 1,
      }

      send(data.merge(message))
    end

    private

    def send(data = {})
      @socket.send(data.to_json, 0)
    end
  end
end
