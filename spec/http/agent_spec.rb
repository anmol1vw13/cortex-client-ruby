require 'spec_helper'

RSpec.describe CortexClient::Http::Agent do
  subject { described_class.new(name: name, version: version) }

  let(:name) { 'client' }
  let(:version) { CortexClient::VERSION }

  describe '#to_s' do
    it 'returns name/version string for agent' do
      expect(subject.to_s).to eq("#{name}/#{version}")
    end
  end

  describe '.list_to_s' do
    it 'returns name/version string for agent' do
      expect(described_class.list_to_s([subject, subject])).to eq("#{subject} #{subject}")
    end
  end
end
