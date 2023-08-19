# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/organization/get-organizations-for-user
#
require "net/http"

module Tursodb
  module OrganizationApi
    class GetAllOrganizationsForUser
      BASE_PATH = "/v1/organizations"

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
        attr_reader :organizations, :empty

        def initialize(data)
          @organizations = data.key?("organizations") ? populate(data) : []
          @empty = !data.key?("organizations")
        end

        private

        def populate(data)
          data["organizations"].map do |organization_data|
            Resources::Organization.new(
              name: organization_data["name"],
              slug: organization_data["slug"],
              type: organization_data["type"]
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
