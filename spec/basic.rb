$LOAD_PATH << "#{File.dirname(__FILE__)}/../"

require 'spec/spec_helper'

describe 'Basic tests' do
  it 'sqs' do
    sqs = Aws::SQS::Client.new
    sqs.create_queue(queue_name: 'test_q',
                     attributes: {
                       'All' => 'String' })

    queue_url = 'https://sqs.us-mockregion-1.amazonaws.com/queue/test_q'
    resp = sqs.send_message(queue_url: queue_url, message_body: 'hi')
    expect(resp['message_id']).not_to be_nil
    resp = sqs.receive_message(queue_url: queue_url, attribute_names: ['All'])
    expect(resp.messages.length).to eq 1
    expect(resp.messages.first.body).to eq 'hi'
    expect(resp.messages.first.md5_of_body).to \
      eq '49f68a5c8493ec2c0bf489821c21fc3b'
  end

  it 's3' do
    s3 = Aws::S3::Client.new(force_path_style: true)

    bucket_name = SecureRandom.hex(10)
    s3.create_bucket(bucket: bucket_name)
    bucket = Aws::S3::Resource.new.bucket(bucket_name)
    # expect(bucket.exists?).to be true

    object = bucket.object('ruby.png')
    object.put(body: File.new("#{File.dirname(__FILE__)}" \
                              '/../public/images/ruby.png'))

    expect(object.exists?)
    expect(object.content_length.positive?)
  end

  it 'dynamodb' do
    dynamo_db = Aws::DynamoDB::Client.new

    dynamo_db.list_tables.table_names.each do |name|
      dynamo_db.delete_table(table_name: name)
    end

    dynamo_db.create_table(
      table_name: 'secrets',
      provisioned_throughput: \
        { read_capacity_units: 1, write_capacity_units: 1 },
      attribute_definitions: [
        { attribute_name: 'name', attribute_type: 'S' }
      ],
      key_schema: [
        { attribute_name: 'name', key_type: 'HASH' }
      ]
    )

    dynamo_db.put_item(
      table_name: 'secrets',
      item: {
        'name' => 'password',
        'date' => Time.now.to_f,
        'value' => 'pa$$w0rd'
      }
    )

    result = dynamo_db.get_item(table_name: 'secrets',
                                key: { 'name' => 'password' })

    expect(result.item['name']).to eq 'password'
    expect(result.item['value']).to eq 'pa$$w0rd'
    expect(Time.at(result.item['date'])).to be_within(5).of(Time.now)
  end
end
