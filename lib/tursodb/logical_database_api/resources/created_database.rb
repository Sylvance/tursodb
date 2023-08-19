# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/create-database-in-org
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class CreatedDatabase
        attr_accessor :credentials, :database

        def initialize(credentials:, database:)
          @credentials = credentials
          @database = database
        end
      end
    end
  end
end
