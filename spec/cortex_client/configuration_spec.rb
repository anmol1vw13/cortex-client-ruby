require 'spec_helper'

RSpec.describe CortexClient::Configuration do
  context 'when configure is called' do
    let(:sample_host) { "sample_host" }
    let(:sample_metrics_push_api_path) { "sample_api" }
    let(:sample_token) { "sample_token" }

    it 'makes a new instance of configuration' do
      CortexClient.configure do |config|
        config.host = sample_host
        config.metrics_push_api_path = sample_metrics_push_api_path
        config.token = sample_token
      end

      expect(CortexClient.configuration.host).to eq(sample_host)
      expect(CortexClient.configuration.metrics_push_api_path).to eq(sample_metrics_push_api_path)
      expect(CortexClient.configuration.token).to eq(sample_token)
    end

    it 'gives an error when host is empty' do
      expect do
        CortexClient.configure do |config|
          config.host = ''
          config.metrics_push_api_path = sample_metrics_push_api_path
          config.token = sample_token
        end
      end.to raise_error(CortexClient::Exception::Configuration)
    end

    it 'gives an error when token is empty' do
      expect do
        CortexClient.configure do |config|
          config.host = sample_host
          config.metrics_push_api_path = sample_metrics_push_api_path
          config.token = ''
        end
      end.to raise_error(CortexClient::Exception::Configuration)
    end

    it 'gives an error when metrics_push_api_path is empty' do
      expect do
        CortexClient.configure do |config|
          config.host = sample_host
          config.metrics_push_api_path = ''
          config.token = sample_token
        end
      end.to raise_error(CortexClient::Exception::Configuration)
    end

    it 'gives an error when host ends with forward slash' do
      expect do
        CortexClient.configure do |config|
          config.host = "#{sample_host}/"
          config.metrics_push_api_path = sample_metrics_push_api_path
          config.token = sample_token
        end
      end.to raise_error(CortexClient::Exception::Configuration)
    end

    it 'gives an error when metrics_push_api_path starts with forward slash' do
      expect do
        CortexClient.configure do |config|
          config.host = sample_host
          config.metrics_push_api_path = "/#{sample_metrics_push_api_path}"
          config.token = sample_token
        end
      end.to raise_error(CortexClient::Exception::Configuration)
    end
  end
end
