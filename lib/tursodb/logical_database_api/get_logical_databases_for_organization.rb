# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/get-database-in-org
#
require "net/http"

module Tursodb
  module LocationApi
    class GetLogicalDatabasesForOrganization
      BASE_PATH = "/v1/organizations"

      def initialize(config)
        @config = config
      end

      def call(org_slug, db_name)
        uri = URI.join(@config.base_url, "#{BASE_PATH}/#{org_slug}/databases/#{db_name}")
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
        attr_reader :database, :empty

        def initialize(data)
          @database = data.key?("database") ? populate(data) : populate_nil_data
          @empty = !data.key?("database")
        end

        private

        def populate(data)
          database = data["database"]
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

        def populate_nil_data
          Resources::LogicalDatabase.new(
            name: nil,
            hostname: nil,
            issued_cert_limit: nil,
            issued_cert_count: nil,
            db_id: nil,
            regions: nil,
            primary_region: nil,
            type: nil
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
