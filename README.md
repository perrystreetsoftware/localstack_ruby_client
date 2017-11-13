# LocalstackRubyClient

Use LocalStack with Ruby.

Because you cannot easily override the endpoints in the ruby aws-sdk, we can use this gem to configure WebMock to re-route requests from [service].[region].amazonaws.com to LocalStack.

(Note that the aws-sdk library for S3 does allow you to easily override its endpoint. Other services do not.)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'localstack_ruby_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install localstack_ruby_client

## Usage

This gem must be used as part of a docker environment in which [LocalStack](https://github.com/localstack/localstack) is installed.

See the docker-compose.yml file as an example.

To run, check out this repo, then from the root run:

```
   docker-compose up -d
   docker exec -it localstack_ruby_client_development_app bash
   bundle exec rake install
   cd examples
   ruby test1.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/perrystreetsoftware/localstack_ruby_client.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
