# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "measures/version"

Gem::Specification.new do |spec|
  spec.name          = "measures"
  spec.version       = Measures::VERSION
  spec.authors       = ["Marcelo Boeira", "Juan Ibiapina"]
  spec.email         = ["me@marceloboeira.com", "juanibiapina@gmail.com"]
  spec.summary       = %q{Measures ruby client}
  spec.description   = %q{Measures ruby client}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "webmock"
end
