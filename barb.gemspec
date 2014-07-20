# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'barb/version'

Gem::Specification.new do |spec|
  spec.name          = "barb"
  spec.version       = Barb::VERSION
  spec.authors       = ["Jason Nochlin"]
  spec.email         = ["hundredwatt@gmail.com"]
  spec.summary       = %q{Placeholder}
  spec.description   = %q{Placeholder}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rack', '>= 1.3.0'
  spec.add_runtime_dependency 'multi_json', '~> 1.0'
  spec.add_runtime_dependency 'multi_xml', '~> 0.5.5'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'bundler'
end
