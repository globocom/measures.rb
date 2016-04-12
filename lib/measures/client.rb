require "json"
require "benchmark"

module Measures
  class Client
    def initialize(transport, client)
      @client = client
      @transport = transport
    end

    def count(metric, data = {})
      data.merge!({ "count" => 1 })

      send(metric, data)
    end

    def time(metric, data = {}, &block)
      elapsed_time = Benchmark.realtime do
        yield if block_given?
      end

      data.merge!({ "time" => elapsed_time })

      send(metric, data)
    end

    private

    def send(metric, data = {})
      default = {
        "client" => @client,
        "metric" => metric,
      }

      default.merge!(data)

      @transport.send(default.to_json)
    end
  end
end
