# Measures Client Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem "measures"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install measures
```

## Usage

```ruby
require "measures"

# Creates the transport (UDP/HTTP/...)
transport = Measures::Transports::UDP.new("logstash.foo.bar", 30)

# Creates the measure client instance
measures = Measures::Client.new(transport, "my-app")

# Sends count metric
measures.count("my_count_metric")

# Sends count metric with additional data
measures.count("my_count_metric", { "foo" => "bar" })

# Sends time metric
measures.time("my_time_metric") do
  # Some long operations
  sleep(10)
end

# Sends time metric with additional data
measures.time("my_time_metric", { "foo" => "bar" }) do
  # Some long operations
  sleep(10)
end
```

## Measures in other languages

- [Python](https://github.com/globocom/measures)
- [Go](https://github.com/scorphus/measures)  
