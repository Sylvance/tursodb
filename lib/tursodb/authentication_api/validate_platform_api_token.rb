# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/auth/validate-token-for-user
#
require "net/http"

module Tursodb
  module AuthenticationApi
    class ValidatePlatformApiToken
      BASE_PATH = "/v1/auth/validate"

      def initialize(config)
        @config = config
      end

      def call
        uri = URI.join(@config.base_url, BASE_PATH)
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "Bearer #{@config.token}"

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        response_struct = Struct.new(:body, :code, :token).new(response.body, response.code, @config.token)
        Shared::Result.new(response_struct, Result, ErrorResponse).call
      rescue StandardError => e
        ErrorResponse.new(e, e.message)
      end

      class Result
        attr_reader :token, :empty

        def initialize(data, token)
          @token = if data.key?("exp")
                     populate(data, token)
                   else
                     Resources::ValidateTokenExpiry.new(expiry: nil, token: token)
                   end
          @empty = !data.key?("exp")
        end

        private

        def populate(data, token)
          Resources::ValidateTokenExpiry.new(
            expiry: data["exp"].to_i == -1 ? Float::INFINITY : data["exp"].to_i,
            token: token
          )
        end
      end

      class ErrorResponse
        attr_reader :error, :message

        def initialize(error, message)
          @error = error
          @message = message
        end
      end
    end
  end
end
