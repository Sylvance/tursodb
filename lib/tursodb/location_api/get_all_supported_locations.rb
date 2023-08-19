# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/location/get-locations
#
require "net/http"

module Tursodb
  module LocationApi
    class GetAllSupportedLocations
      BASE_PATH = "/v1/locations"

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
        attr_reader :locations, :empty

        def initialize(data)
          @locations = data.key?("locations") ? populate(data) : []
          @empty = !data.key?("locations")
        end

        private

        def populate(data)
          data["locations"].map do |key, value|
            Resources::Location.new(
              symbol: key,
              name: value
            )
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
