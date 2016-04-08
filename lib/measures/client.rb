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

      data = data.merge(message)

      @socket.send(data.to_json, 0)
    end
  end
end
