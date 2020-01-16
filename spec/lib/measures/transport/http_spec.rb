require "webmock/rspec"

RSpec.describe Measures::Transports::HTTP do
  let(:host) { "host.com" }
  let(:url) { "/path" }
  let(:port) { 3132 }
  let(:data) { "some_data" }
  let(:open_timeout) { 20 }
  let(:timeout) { 30 }

  before do
    stub_request(:post, "http://host.com:3132").
      with(body: "some_data", headers: {
      "Content-Type"=>"application/json",
    }).to_return(status: 200, body: "", headers: {})
  end

  before do
    stub_request(:post, "http://host.com:3132/path").
      with(body: "some_data", headers: {
      "Content-Type"=>"application/json",
    }).to_return(status: 200, body: "", headers: {})
  end

  context "with host and port" do
    let(:http) { Measures::Transports::HTTP.new(host, port) }

    it "sends data over http" do
      http.send(data)

      expect(a_request(:post, "http://host.com:3132")).to have_been_made.once
    end
  end

  context "with host, port and url" do
    let(:http) { Measures::Transports::HTTP.new(host, port, url) }

    it "sends data over http" do
      http.send(data)

      expect(a_request(:post, "http://host.com:3132/path")).to have_been_made.once
    end
  end

  context "with open_timeout and timeout" do
    let(:http) { Measures::Transports::HTTP.new(host, port, url, open_timeout, timeout) }

    it "sets open_timeout option" do
      expect(http.client.options.open_timeout).to eq(20)
    end

    it "sets timeout option" do
      expect(http.client.options.timeout).to eq(30)
    end
  end
end
