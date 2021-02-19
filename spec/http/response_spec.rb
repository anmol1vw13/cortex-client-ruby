require 'spec_helper'

RSpec.describe CortexClient::Http::Response do
  subject { described_class.new(http_response) }

  let(:response_code) { 201 }
  let(:response_body) do
    { 'success' => true, 'errors' => [], 'data' => {} }.to_json
  end
  let(:http_response) { double(HTTP::Response, content_type: 'application/json', code: response_code, body: response_body) }

  describe '#ok?' do
    context 'when response code is 200' do
      let(:response_code) { 200 }

      it 'returns true' do
        expect(subject).to be_ok
      end
    end

    context 'when response code is not 200' do
      let(:response_code) { 404 }

      it 'returns false' do
        expect(subject).not_to be_ok
      end
    end
  end

  describe '#bad_request?' do
    context 'when response code is 400' do
      let(:response_code) { 400 }

      it 'returns true' do
        expect(subject).to be_bad_request
      end
    end

    context 'when response code is not 400' do
      let(:response_code) { 200 }

      it 'returns false' do
        expect(subject).not_to be_bad_request
      end
    end
  end

  describe '#unauthorized?' do
    context 'when response code is 401' do
      let(:response_code) { 401 }

      it 'returns true' do
        expect(subject).to be_unauthorized
      end
    end

    context 'when response code is not 401' do
      let(:response_code) { 200 }

      it 'returns false' do
        expect(subject).not_to be_unauthorized
      end
    end
  end

  describe '#forbidden?' do
    context 'when response code is 403' do
      let(:response_code) { 403 }

      it 'returns true' do
        expect(subject).to be_forbidden
      end
    end

    context 'when response code is not 403' do
      let(:response_code) { 200 }

      it 'returns false' do
        expect(subject).not_to be_forbidden
      end
    end
  end

  describe '#server_error?' do
    context 'when response code is 500, 502, 503 or 504' do
      [500, 502, 503, 504].each do |status_code|
        let(:response_code) { status_code }

        it 'returns true' do
          expect(subject).to be_server_error
        end
      end
    end

    context 'when response code is not 500, 502, 503 or 504' do
      let(:response_code) { 200 }

      it 'returns false' do
        expect(subject).not_to be_server_error
      end
    end
  end

  describe '#network_error?' do
    context 'when response code is 502, 503 or 504' do
      [502, 503, 504].each do |status_code|
        let(:response_code) { status_code }

        it 'returns true' do
          expect(subject).to be_network_error
        end
      end
    end

    context 'when response code is not 502, 503 or 504' do
      let(:response_code) { 200 }

      it 'returns false' do
        expect(subject).not_to be_network_error
      end
    end
  end

  describe '#not_found?' do
    context 'when response code is 404' do
      let(:response_code) { 404 }

      it 'returns true' do
        expect(subject).to be_not_found
      end
    end

    context 'when response code is not 404' do
      let(:response_code) { 200 }

      it 'returns false' do
        expect(subject).not_to be_not_found
      end
    end
  end

  describe '#successful?' do
    context 'when response code is 200, 201 or 202' do
      [200, 201, 202].each do |status_code|
        let(:response_code) { status_code }

        it 'returns true' do
          expect(subject).to be_successful
        end
      end
    end

    context 'when response code is not 200, 201 or 202' do
      let(:response_code) { 404 }

      it 'returns false' do
        expect(subject).not_to be_successful
      end
    end
  end
end
