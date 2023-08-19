# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/create-database-in-org
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class UpdatedDatabase
        attr_accessor :success, :done

        def initialize(success:, done:)
          @success = success
          @done = done
        end
      end
    end
  end
end
