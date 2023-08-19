# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/auth/get-tokens-for-user
#
require "net/http"

module Tursodb
  module AuthenticationApi
    class GetAllPlatformApiTokens
      BASE_PATH = "/v1/auth/api-tokens"

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

        Shared::Result.new(response, Result, ErrorResponse).call
      rescue StandardError => e
        ErrorResponse.new(e, e.message)
      end

      class Result
        attr_reader :tokens, :empty

        def initialize(data)
          @tokens = data.key?("tokens") ? populate(data) : []
          @empty = data.key?("tokens")
        end

        private

        def populate(data)
          data["tokens"].map do |token_data|
            Resources::PlatformApiToken.new(id: token_data["id"], name: token_data["name"])
          end
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
