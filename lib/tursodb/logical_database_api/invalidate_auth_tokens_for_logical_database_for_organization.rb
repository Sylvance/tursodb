# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/invalidate-all-tokens-for-database-in-org
#
require "net/http"

module Tursodb
  module LocationApi
    class InvalidateAuthTokensForLogicalDatabaseForOrganization
      BASE_PATH = "/v1/organizations"

      def initialize(config)
        @config = config
      end

      def call(org_slug, name)
        uri = URI.join(@config.base_url, "#{BASE_PATH}/#{org_slug}/databases/#{name}/auth/rotate")
        request = Net::HTTP::Post.new(uri)
        request["Authorization"] = "Bearer #{@config.token}"

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        Shared::Result.new(response, Result, ErrorResponse).call
      rescue StandardError => e
        ErrorResponse.new(e, e.message)
      end

      class Result
        attr_reader :database, :empty

        def initialize(data)
          @database = Resources::InvalidatedToken.new(
            success: true,
            database: data
          )
          @empty = false
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
