# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daimon/markdown/version'

Gem::Specification.new do |spec|
  spec.name          = "daimon-markdown"
  spec.version       = Daimon::Markdown::VERSION
  spec.authors       = ["daimon developers"]
  spec.email         = [""]

  spec.summary       = %q{Markdown renderer for Daimon}
  spec.description   = %q{Markdown renderer for Daimon}
  spec.homepage      = "https://github.com/bm-sms/daimon-markdown"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.3.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "html-pipeline"
  spec.add_runtime_dependency "redcarpet"
  spec.add_runtime_dependency "rouge"

  spec.add_development_dependency "bundler", ">= 1.12"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "test-unit", "> 3"
  spec.add_development_dependency "test-unit-notify"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "daimon-deka"
end
