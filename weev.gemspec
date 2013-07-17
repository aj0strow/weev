# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weev/version'

Gem::Specification.new do |spec|
  spec.name = 'weev'
  spec.version = Weev::VERSION
  spec.authors = %w(aj0strow)
  spec.email = 'alexander.ostrow@gmail.com'
  spec.description = 'organized JSON serialization'
  spec.summary = 'easily serialize ruby objects'
  spec.homepage = 'http://github.com/aj0strow/weev'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(/spec/)
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'multi_json'
end
