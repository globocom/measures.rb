require "spec_helper"

RSpec.describe Measures::Transport::UDP do
  let(:host) { "localhost" }
  let(:port) { 6000 + rand(999) }
  let!(:server) { UDPSocket.new }
  let(:transport) { Measures::Transport::UDP.new(host, port) }

  def read(size)
    server.recvfrom(size)[0]
  end

  before do
    server.bind(host, port)
  end

  it "transports the package" do
    size = transport.send("foo")

    expect(read(size)).to eq("foo")
  end
end
