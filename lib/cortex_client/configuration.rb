module CortexClient
  class Configuration
    attr_accessor :token, :host, :metrics_push_api_path
    attr_reader :read_timeout, :connect_timeout, :write_timeout, :agents

    def initialize
      @host = ''
      @token = ''
      @metrics_push_api_path = ''
      @read_timeout = 75
      @connect_timeout = 10
      @write_timeout = 75
      @agents = [Http::Agent.new(name: CortexClient.name, version: CortexClient::VERSION)]
    end

    def valid?
      !@token.empty? &&
          !@host.empty? &&
          !@host.end_with?('/') &&
          !@metrics_push_api_path.empty? &&
          !@metrics_push_api_path.start_with?('/')
    end

    def agent=(agent_attributes)
      @agents.push(Http::Agent.new(agent_attributes))
    end

    def agent
      Http::Agent.list_to_s(@agents)
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
    raise Exception::Configuration unless configuration.valid?
  end
end
