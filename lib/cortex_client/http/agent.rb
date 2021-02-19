module CortexClient
  module Http
    class Agent
      attr_reader :name, :version

      def initialize(name:, version:)
        @name = name
        @version = version
      end

      def self.list_to_s(agents)
        agents.collect(&:to_s).join(" ")
      end

      def to_s
        "#{name}/#{version}".freeze
      end
    end
  end
end
