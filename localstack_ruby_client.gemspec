# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'localstack_ruby_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'localstack_ruby_client'
  spec.version       = LocalstackRubyClient::VERSION
  spec.authors       = ['Eric Silverberg']
  spec.email         = ['eric@<my company>.com']

  spec.summary       = %q{Use LocalStack with ruby clients}
  spec.description   = %q{A library that lets you connect to LocalStack from ruby}
  spec.homepage      = "https://github.com/perrystreetsoftware/localstack_ruby_client"
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'webmock', '~> 3.1'
  spec.add_dependency 'aws-sdk-dynamodb', '~> 1.2'
  spec.add_dependency 'aws-sdk-s3', '~> 1.6'
  spec.add_dependency 'aws-sdk-sqs', '~> 1.3'
  spec.add_dependency 'httparty', '~> 0.15'
end
