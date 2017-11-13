# frozen_string_literal: true

# Helpfully explained here: http://lizabinante.com/blog/creating-a-configurable-ruby-gem/
module LocalstackRubyClient
  # Configure clientside aws
  class Configuration
    attr_accessor :host
    attr_accessor :mapping

    def initialize
      mapping_file = File.dirname(__FILE__) + '/localstack_mapping.yml'

      @host = 'localstack'
      @mapping = YAML.load_file(mapping_file)
    end

    def port(host)
      service = host.split('.us-mockregion-1').first
      service = if service =~ /s3$/
                  :s3
                else
                  service.to_sym
                end

      raise 'unmapped service' unless @mapping.key?(service)
      @mapping[service]
    end
  end
end
