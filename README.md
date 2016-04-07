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

# Creates the measure client instance
measures = Measures::Client.new("my-app", "logstash.foo.bar", 30)

# Sends metric
measures.count("my_metric")

# Sends metric with additional data
measures.count("my_metric", { "foo" => "bar" })
```
