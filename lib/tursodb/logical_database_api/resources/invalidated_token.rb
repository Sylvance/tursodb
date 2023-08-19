# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/create-database-in-org
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class InvalidatedToken
        attr_accessor :success, :database

        def initialize(success:, database:)
          @success = success
          @database = database
        end
      end
    end
  end
end
