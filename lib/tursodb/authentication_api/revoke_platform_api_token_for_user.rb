# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/auth/revoke-token-for-user
#
require "net/http"

module Tursodb
  module AuthenticationApi
    class RevokePlatformApiTokenForUser
      BASE_PATH = "/v1/auth/api-tokens"

      def initialize(config)
        @config = config
      end

      def call(token_name)
        uri = URI.join(@config.base_url, "#{BASE_PATH}/#{token_name}")
        request = Net::HTTP::Delete.new(uri)
        request["Authorization"] = "Bearer #{@config.token}"

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        Shared::Result.new(response, Result, ErrorResponse).call
      rescue StandardError => e
        ErrorResponse.new(e, e.message)
      end

      class Result
        attr_reader :token, :empty

        def initialize(data)
          @token = data.key?("token") ? populate(data) : Resources::PlatformApiToken.new(id: nil, name: nil, token: nil)
          @empty = !data.key?("token")
        end

        private

        def populate(data)
          Resources::PlatformApiToken.new(id: nil, name: nil, token: data["token"])
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
