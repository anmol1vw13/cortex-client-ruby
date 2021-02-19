require 'spec_helper'

RSpec.describe CortexClient::Metric do
  subject { described_class.new(metric_name) }

  let(:metric_name) { 'sample_metric' }
  let(:label_one) { 'label_one' }
  let(:label_value_one) { 'label_value_one' }

  it 'adds metric label' do
    expect(subject.labels[0].name).to eq('__name__')
    expect(subject.labels[0].value).to eq(metric_name)
  end

  context 'when add label is called' do
    it 'adds a label entry in the labels array' do
      subject.add_label(name: label_one, value: label_value_one)

      expect(subject.labels.size).to eq(2)
      expect(subject.labels[1].name).to eq(label_one)
      expect(subject.labels[1].value).to eq(label_value_one)
    end
  end

  context 'when add sample is called' do
    let(:sample_value_one) { 1 }

    it 'adds a sample entry in the samples array' do
      subject.add_sample(value: sample_value_one)

      expect(subject.samples.size).to eq(1)
      expect(subject.samples[0].value).to eq(sample_value_one)
      expect(subject.samples[0].timestamp).not_to be_nil
    end
  end

  context 'when push is called' do
    let(:error) { 'error' }

    it 'adds error to instance when samples or labels are not added' do
      subject.push
      expect(subject.error).not_to be_nil
    end

    it 'adds prom_message to instance when response is 200' do
      resp = CortexClient::Http::Response.new(double(HTTP::Response, code: 200, body: ''))
      allow_any_instance_of(CortexClient::Http::Request).to receive(:post).and_return(resp)
      subject.add_label(name: label_one, value: label_value_one).
        add_sample(value: 1).push

      expect(subject.prom_message).not_to be_nil
      expect(subject.error).to be_nil
    end

    it 'adds custom error to instance when response is not 200' do
      resp = CortexClient::Http::Response.new(double(HTTP::Response, code: 400, body: ''))
      allow_any_instance_of(CortexClient::Http::Request).to receive(:post).and_return(resp)
      subject.add_label(name: label_one, value: label_value_one).
        add_sample(value: 1).push
      expect(subject.error).to eq('Metric couldn\'t be posted')
      expect(subject.prom_message).to be_nil
    end

    it 'adds error returned in the response to instance when response is not 200' do
      resp = CortexClient::Http::Response.new(double(HTTP::Response, code: 400, body: error))
      allow_any_instance_of(CortexClient::Http::Request).to receive(:post).and_return(resp)
      subject.add_label(name: label_one, value: label_value_one).
        add_sample(value: 1).push
      expect(subject.error).to eq(error)
      expect(subject.prom_message).to be_nil
    end
  end
end
