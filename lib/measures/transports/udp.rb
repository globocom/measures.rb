require "socket"

module Measures
  module Transports
    class UDP
      def initialize(host, port)
        @socket = UDPSocket.new
        @socket.connect(host, port)
      end

      def send(data)
        @socket.send(data, 0)
      end
    end
  end
end
