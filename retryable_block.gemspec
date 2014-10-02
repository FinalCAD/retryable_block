# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retryable_block/version'

Gem::Specification.new do |spec|
  spec.name          = "retryable_block"
  spec.version       = RetryableBlock::VERSION
  spec.authors       = ["Steve Chung"]
  spec.email         = ["steve.chung7@gmail.com"]
  spec.summary       = %q{Retry block if it returns errors.}
  spec.description   = %q{A module that adds #retryable to your classes.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "1.6.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
