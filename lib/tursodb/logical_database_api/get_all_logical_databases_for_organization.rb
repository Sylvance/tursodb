# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/get-databases-in-org
#
require "net/http"

module Tursodb
  module LocationApi
    class GetAllLogicalDatabasesForOrganization
      BASE_PATH = "/v1/organizations"

      def initialize(config)
        @config = config
      end

      def call(org_slug)
        uri = URI.join(@config.base_url, "#{BASE_PATH}/#{org_slug}/databases")
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
        attr_reader :databases, :empty

        def initialize(data)
          @databases = data.key?("databases") ? populate(data) : []
          @empty = !data.key?("databases")
        end

        private

        def populate(data)
          data["databases"].map do |database|
            Resources::LogicalDatabase.new(
              name: database["Name"],
              hostname: database["Hostname"],
              issued_cert_limit: database["IssuedCertLimit"],
              issued_cert_count: database["IssuedCertCount"],
              db_id: database["DbId"],
              regions: database["regions"],
              primary_region: database["primaryRegion"],
              type: database["type"]
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
