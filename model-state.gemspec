# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'model-state/version'

Gem::Specification.new do |spec|
  spec.name          = "model-state"
  spec.version       = ModelState::VERSION
  spec.authors       = ["Kaid"]
  spec.email         = ["kaid@kaid.me"]
  spec.summary       = %q{Flexible state for mongoid.}
  spec.description   = %q{Flexible state for mongoid.}
  spec.homepage      = "https://github.com/mindpin/model-state-gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mongoid", "~> 4.0.0.rc1"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its", "~> 1.0"
  spec.add_development_dependency "pry"
end
