require "webmock/rspec"

RSpec.describe Measures::Transport::HTTP do
  let(:host) { "host.com" }
  let(:port) { 3132 }
  let(:http) { Measures::Transport::HTTP.new(host, port) }
  let(:data) { "some_data" }

  before do
    stub_request(:post, "http://host.com:3132").
      with(body: "some_data", headers: {
      "Content-Type"=>"application/json",
    }).to_return(status: 200, body: "", headers: {})
  end

  it "sends data over http" do
    http.send(data)

    expect(a_request(:post, "http://host.com:3132")).to have_been_made.once
  end
end
