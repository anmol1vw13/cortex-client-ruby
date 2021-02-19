module CortexClient
  class Metric
    attr_reader :labels, :samples, :prom_message, :error, :custom_error_message
    def initialize(metric_name)
      @config = CortexClient.configuration
      @labels = []
      @samples = []
      @error = nil
      @prom_message = nil
      # a label with __name__ is required by cortex
      # to identify the metric name
      add_label(name: '__name__', value: metric_name)
    end

    def add_label(name:, value:)
      label = Prometheus::Label.new(name: name, value: value)
      @labels.push(label)
      self
    end

    def add_sample(value: 1)
      time = (Time.now.to_f * 1000).to_i
      sample = Prometheus::Sample.new(timestamp: time, value: value)
      @samples.push(sample)
      self
    end

    def push
      if @labels.size <= 1 || @samples.size == 0
        @error = 'Use add_label and add_sample at-least once'
        return
      end

      timeseries = Prometheus::TimeSeries.new(labels: @labels, samples: @samples)
      writerequest = Prometheus::WriteRequest.new(timeseries: [].push(timeseries))
      compressed_data = Snappy.compress(Prometheus::WriteRequest.encode(writerequest))
      response = CortexClient::Http::Request.new.post(@config.metrics_push_api_path, compressed_data)
      if response.ok?
        @prom_message = response.body.to_s
        @error = nil
      else
        @prom_message = nil
        @error = response_formatter(response: response, custom_message: 'Metric couldn\'t be posted')
      end
    end

    private

    def response_formatter(response:, custom_message:)
      if response.body.empty?
        custom_message
      else
        response.body.to_s
      end
    end
  end
end
