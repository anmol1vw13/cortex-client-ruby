module CortexClient
  module Http
    class Response
      attr_reader :body, :response_code

      def initialize(http_response)
        @response_code = http_response.code
        @body = http_response.body
        @http_response = http_response
      end

      def ok?
        @response_code == 200
      end

      def created?
        @response_code == 201
      end

      def accepted?
        @response_code == 202
      end

      def bad_request?
        @response_code == 400
      end

      def forbidden?
        @response_code == 403
      end

      def unauthorized?
        @response_code == 401
      end

      def not_found?
        @response_code == 404
      end

      def unprocessable_entity?
        @response_code == 422
      end

      def successful?
        successful_codes = [200, 201, 202]
        successful_codes.include?(@response_code)
      end

      def server_error?
        server_error_codes = [500, 502, 503, 504]

        server_error_codes.include?(@response_code)
      end

      def network_error?
        server_error_codes = [502, 503, 504]

        server_error_codes.include?(@response_code)
      end
    end
  end
end
