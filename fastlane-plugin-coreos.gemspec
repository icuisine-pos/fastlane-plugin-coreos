# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/coreos/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-coreos'
  spec.version       = Fastlane::Coreos::VERSION
  spec.author        = %q{Oliver Letterer}
  spec.email         = %q{oliver.letterer@gmail.com}

  spec.summary       = %q{Deploys docker services to CoreOS hosts.}
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-coreos"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency "net-ssh", "~> 3.2.0"
  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.101.0'
end
