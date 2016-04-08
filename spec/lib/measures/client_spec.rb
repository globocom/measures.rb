require "spec_helper"
require "socket"
require_relative "../../../lib/measures"

RSpec.describe Measures::Client do
  let(:host) { "localhost" }
  let(:port) { 6000 + rand(999) }
  let!(:server) { UDPSocket.new }
  let(:client) { Measures::Client.new("foo", host, port) }

  def receive(size)
    JSON.parse(server.recvfrom(size)[0])
  end

  before do
    server.bind(host, port)
  end

  describe "message content" do
    let(:package) { receive(size) }
    let(:data) { { } }
    let(:size) { client.count("bar", data) }

    it "includes client" do
      expect(package).to include("client" => "foo")
    end

    it "includes metric" do
      expect(package).to include("metric" => "bar")
    end

    it "includes count" do
      expect(package).to include("count" => 1)
    end

    context "with additional data" do
      let(:data) { { "server" => "foo.bar" } }

      it "includes data content" do
        expect(package).to include(data)
      end
    end
  end
end
