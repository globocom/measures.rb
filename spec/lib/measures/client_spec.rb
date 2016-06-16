require "spec_helper"

RSpec::Matchers.define :receive_data_including do |hash|
  match do |transport|
    expect(transport).to receive(:send) do |data|
      expect(JSON.parse(data)).to include(hash)
    end
  end
end


RSpec.describe Measures::Client do
  let(:transport) { double(:transport) }
  let(:client_name) { "foo" }
  let(:owner_name) { "bar" }
  let(:client) { Measures::Client.new(transport, client_name, owner_name) }

  before do
    allow(transport).to receive(:send)
  end

  describe "count" do
    describe "message content" do
      let(:data) { {} }
      let(:metric_name) { "bar" }

      after(:each) do
        client.count(metric_name, data)
      end

      it "includes owner" do
        expect(transport).to receive_data_including("owner" => owner_name)
      end

      it "includes client" do
        expect(transport).to receive_data_including("client" => client_name)
      end

      it "includes metric" do
        expect(transport).to receive_data_including("metric" => metric_name)
      end

      it "includes count" do
        expect(transport).to receive_data_including("count" => 1)
      end

      context "with additional data" do
        let(:data) { { "server" => "foo.bar" } }

        it "includes data content" do
          expect(transport).to receive_data_including(data)
        end
      end
    end
  end

  describe "time" do
    it "yield the block" do
      expect{ |block| client.time("foo", &block) }.to yield_with_no_args
    end

    describe "message content" do
      let(:data) { {} }

      before do
        allow(Benchmark).to receive(:realtime).and_return(8.32)
      end

      after(:each) do
        client.time("bar", data) { }
      end

      it "includes client" do
        expect(transport).to receive_data_including("client" => "foo")
      end

      it "includes metric" do
        expect(transport).to receive_data_including("metric" => "bar")
      end

      it "includes time" do
        expect(transport).to receive_data_including("time" => 8.32)
      end

      context "with additional data" do
        let(:data) { { "server" => "foo.bar" } }

        it "includes data content" do
          expect(transport).to receive_data_including(data)
        end
      end
    end
  end
end
