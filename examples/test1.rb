require 'rubygems'
require 'localstack_ruby_client'
require 'aws-sdk-s3'

s3 = Aws::S3::Client.new(force_path_style: true)

bucket_name = SecureRandom.hex(10)
s3.create_bucket(bucket: bucket_name)
bucket = Aws::S3::Resource.new.bucket(bucket_name)

object = bucket.object('ruby.png')
object.put(body: File.new("#{File.dirname(__FILE__)}" \
                          '/../public/images/ruby.png'))

puts object.exists?
puts object.content_length.positive?
