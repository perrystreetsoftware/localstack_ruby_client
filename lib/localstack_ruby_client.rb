require File.dirname(__FILE__) + '/localstack_ruby_client/configuration'

module LocalstackRubyClient
  require File.dirname(__FILE__) + '/localstack_ruby_client/version'
  require File.dirname(__FILE__) + '/localstack_ruby_client/mock'

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
