# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/attack/cassandra/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-attack-cassandra"
  spec.version       = Rack::Attack::Cassandra::VERSION
  spec.authors       = ["Jack Chen (chendo)"]
  spec.email         = ["github@chen.do"]
  spec.summary       = %q{An adapter for using Rack::Attack with Cassandra}
  spec.description   = %q{An adapter for using Rack::Attack with Cassandra.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'cassandra-driver', "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
