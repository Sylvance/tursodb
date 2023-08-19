# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/create-database-in-org
#
require "net/http"

module Tursodb
  module LocationApi
    class CreateLogicalDatabaseForOrganization
      BASE_PATH = "/v1/organizations"

      def initialize(config)
        @config = config
      end

      def call(org_slug, name, image)
        uri = URI.join(@config.base_url, "#{BASE_PATH}/#{org_slug}/databases")
        request = Net::HTTP::Post.new(uri)
        request["Authorization"] = "Bearer #{@config.token}"
        request["Content-Type"] = "application/json"
        request.body = { name: name, image: image }.to_json

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
          @database = if data.key?("database")
                        populate(data)
                      else
                        Resources::CreatedDatabase.new(
                          credentials: nil,
                          database: nil
                        )
                      end
          @empty = !data.key?("database")
        end

        private

        def populate(data)
          database = data["database"]
          credentials = data.except("database")

          Resources::CreatedDatabase.new(
            credentials: creds_from(credentials),
            database: db_from(database)
          )
        end

        def creds_from(credentials)
          Resources::Credentials.new(
            username: credentials["username"],
            password: credentials["password"]
          )
        end

        def db_from(database)
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
