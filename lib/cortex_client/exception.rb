module CortexClient
  module Exception
    class Configuration < StandardError
    end

    class ConnectionRefused < StandardError
    end

    class ConnectionError < StandardError
    end

    class Timeout < StandardError
    end

    class NetworkError < StandardError
    end
  end
end
