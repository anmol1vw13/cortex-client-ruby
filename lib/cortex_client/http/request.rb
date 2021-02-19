module CortexClient
  module Http
    class Request
      def initialize
        @config = CortexClient.configuration
        @host = @config.host
        @client = http
      end

      def post(path, body)
        wrap_failure do
          Response.new(@client.post(uri(@host, path), :body => body))
        end
      end

      private

      def uri(base_uri, path)
        File.join(base_uri, path)
      end

      def wrap_failure(&block)
        yield(block)
      rescue Errno::ECONNREFUSED => e
        raise Exception::ConnectionRefused.new(e.message)
      rescue HTTP::ConnectionError => e
        raise Exception::ConnectionError.new(e.message)
      rescue HTTP::TimeoutError => e
        raise Exception::Timeout.new(e.message)
      end

      def headers
        {
          'Content-Encoding' => 'snappy',
          'Content-Type' => 'application/x-protobuf',
          'X-Prometheus-Remote-Write-Version' => '0.1.0',
          'Authorization' => "Bearer #{@config.token}",
          'User-Agent' => @config.agent,
        }
      end

      def http
        HTTP.timeout(
          connect: @config.connect_timeout,
          read: @config.read_timeout,
          write: @config.write_timeout
        ).headers(headers)
      end
    end
  end
end
