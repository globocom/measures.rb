require "spec_helper"
require "socket"
require_relative "../../../lib/measures"

RSpec.describe Measures::Client do
  let(:host) { "localhost" }
  let(:port) { 6000 + rand(999) }
  let!(:server) { UDPSocket.new }
  let(:client) { Measures::Client.new("foo", host, port) }

  def read(size)
    JSON.parse(server.recvfrom(size)[0])
  end

  before do
    server.bind(host, port)
  end

  describe "count" do
    describe "message content" do
      let(:package) { read(size) }
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

  describe "time" do
    it "yield the block" do
      expect{ |block| client.time("foo", &block) }.to yield_with_no_args
    end

    describe "message content" do
      let(:package) { read(size) }
      let(:data) { { } }
      let(:size) { client.time("bar", data) }

      before do
        allow(Benchmark).to receive(:realtime).and_return(8.32)
      end

      it "includes client" do
        expect(package).to include("client" => "foo")
      end

      it "includes metric" do
        expect(package).to include("metric" => "bar")
      end

      it "includes time" do
        expect(package).to include("time" => 8.32)
      end

      context "with additional data" do
        let(:data) { { "server" => "foo.bar" } }

        it "includes data content" do
          expect(package).to include(data)
        end
      end
    end
  end
end
