require 'httparty'
require 'webmock'
require 'aws-sdk-dynamodb'
require 'aws-sdk-s3'
require 'aws-sdk-sqs'

WebMock.enable!
allowed_http = ['localstack']
WebMock.disable_net_connect!(allow: allowed_http)

def mock_uri(uri:)
  port = LocalstackRubyClient.configuration.port(uri.host)

  uri.scheme = 'http'
  uri.host = LocalstackRubyClient.configuration.host
  uri.port = port

  uri
end

def mock_post(request:)
  response = HTTParty.post(mock_uri(uri: request.uri),
                           body: request.body,
                           headers: \
                            request.headers.merge('SERVER_NAME' => \
                                                  request.uri.host))

  { headers: response.headers,
    status: response.code,
    body: response.body }
end

def mock_get(request:)
  response = HTTParty.get(mock_uri(uri: request.uri),
                          query: request.uri.query_values,
                          headers: \
                            request.headers.merge('SERVER_NAME' => \
                                                  request.uri.host))

  { headers: response.headers,
    status: response.code,
    body: response.body }
end

def mock_head(request:)
  response = HTTParty.get(mock_uri(uri: request.uri),
                          query: request.uri.query_values,
                          headers: \
                            request.headers.merge('SERVER_NAME' => \
                                                  request.uri.host))

  { headers: response.headers,
    status: response.code,
    body: '' }
end

def mock_put(request:)
  response = HTTParty.put(mock_uri(uri: request.uri),
                          body: request.body,
                          headers: \
                            request.headers.merge('SERVER_NAME' => \
                                                  request.uri.host))

  { headers: response.headers,
    status: response.code,
    body: response.body }
end

def mock_delete(request:)
  response = HTTParty.delete(mock_uri(uri: request.uri),
                             query: request.uri.query_values,
                             headers: \
                               request.headers.merge('SERVER_NAME' => \
                                                     request.uri.host))

  { headers: response.headers,
    status: response.code,
    body: response.body }
end

# Use WebMock to intercept all requests and redirect to our container
WebMock.stub_request(:post, %r{https?\:\/\/[\w\.]+\.us\-mockregion\-1}) \
       .to_return do |request|
  mock_post(request: request)
end

WebMock.stub_request(:get, %r{https?\:\/\/[\w\.]+\.us\-mockregion\-1}) \
       .to_return do |request|
  mock_get(request: request)
end

WebMock.stub_request(:head, %r{https?\:\/\/[\w\.]+\.us\-mockregion\-1}) \
       .to_return do |request|
  mock_head(request: request)
end

WebMock.stub_request(:put, %r{https?\:\/\/[\w\.]+\.us\-mockregion\-1}) \
       .to_return do |request|
  mock_put(request: request)
end

WebMock.stub_request(:delete, %r{https?\:\/\/[\w\.]+\.us\-mockregion\-1}) \
       .to_return do |request|
  mock_delete(request: request)
end


# Update AWS config
config = { region: 'us-mockregion-1',
           access_key_id: '...',
           secret_access_key: '...' }

Aws.config.update(config)
