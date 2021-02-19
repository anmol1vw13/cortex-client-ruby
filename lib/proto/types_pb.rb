# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: types.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("types.proto", :syntax => :proto3) do
    add_message "prometheus.Sample" do
      optional :value, :double, 1
      optional :timestamp, :int64, 2
    end
    add_message "prometheus.TimeSeries" do
      repeated :labels, :message, 1, "prometheus.Label"
      repeated :samples, :message, 2, "prometheus.Sample"
    end
    add_message "prometheus.Label" do
      optional :name, :string, 1
      optional :value, :string, 2
    end
    add_message "prometheus.Labels" do
      repeated :labels, :message, 1, "prometheus.Label"
    end
    add_message "prometheus.LabelMatcher" do
      optional :type, :enum, 1, "prometheus.LabelMatcher.Type"
      optional :name, :string, 2
      optional :value, :string, 3
    end
    add_enum "prometheus.LabelMatcher.Type" do
      value :EQ, 0
      value :NEQ, 1
      value :RE, 2
      value :NRE, 3
    end
    add_message "prometheus.ReadHints" do
      optional :step_ms, :int64, 1
      optional :func, :string, 2
      optional :start_ms, :int64, 3
      optional :end_ms, :int64, 4
      repeated :grouping, :string, 5
      optional :by, :bool, 6
      optional :range_ms, :int64, 7
    end
    add_message "prometheus.Chunk" do
      optional :min_time_ms, :int64, 1
      optional :max_time_ms, :int64, 2
      optional :type, :enum, 3, "prometheus.Chunk.Encoding"
      optional :data, :bytes, 4
    end
    add_enum "prometheus.Chunk.Encoding" do
      value :UNKNOWN, 0
      value :XOR, 1
    end
    add_message "prometheus.ChunkedSeries" do
      repeated :labels, :message, 1, "prometheus.Label"
      repeated :chunks, :message, 2, "prometheus.Chunk"
    end
  end
end

module Prometheus
  Sample = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.Sample").msgclass
  TimeSeries = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.TimeSeries").msgclass
  Label = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.Label").msgclass
  Labels = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.Labels").msgclass
  LabelMatcher = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.LabelMatcher").msgclass
  LabelMatcher::Type = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.LabelMatcher.Type").enummodule
  ReadHints = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.ReadHints").msgclass
  Chunk = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.Chunk").msgclass
  Chunk::Encoding = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.Chunk.Encoding").enummodule
  ChunkedSeries = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("prometheus.ChunkedSeries").msgclass
end
