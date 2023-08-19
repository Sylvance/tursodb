# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/auth/get-tokens-for-user
#
require "net/http"

module Tursodb
  module OrganizationApi
    class GetAllOrganizationMembers
      BASE_PATH = "/v1/organizations"

      def initialize(config)
        @config = config
      end

      def call(slug)
        uri = URI.join(@config.base_url, "#{BASE_PATH}/#{slug}/members")
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
        attr_reader :members, :empty

        def initialize(data)
          @members = data.key?("members") ? populate(data) : []
          @empty = !data.key?("members")
        end

        private

        def populate(data)
          data["members"].map do |member_data|
            Resources::Member.new(role: member_data["role"], username: member_data["username"])
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
