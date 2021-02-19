require 'spec_helper'

RSpec.describe CortexClient::Http::Request do
  subject { described_class.new }

  let(:http_response) { double(HTTP::Response, status: 200, body: '') }

  before :each do
    CortexClient.configure do |config|
      config.host = 'https://lens.golabs.io'
      config.metrics_push_api_path = 'v1/prom/metrics'
      config.token = "sample_token"
    end
  end

  describe '#post' do
    it 'makes a post call successfully' do
      stub = stub_request(:post, "#{CortexClient.configuration.host}/#{CortexClient.configuration.metrics_push_api_path}").
        to_return(status: 200, body: '')
      response = subject.post(CortexClient.configuration.metrics_push_api_path, '')

      expect(stub).to have_been_requested
      expect(response).to be_a(CortexClient::Http::Response)
      expect(response.ok?).to be_truthy
    end

    it 'handles timeout while making call to Cortex' do
      stub = stub_request(:post, "#{CortexClient.configuration.host}/#{CortexClient.configuration.metrics_push_api_path}").
        to_raise(HTTP::TimeoutError)

      expect { subject.post(CortexClient.configuration.metrics_push_api_path, '') }.to raise_error(CortexClient::Exception::Timeout)
      expect(stub).to have_been_requested
    end
  end
end
