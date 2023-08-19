# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/#logical-database-usage-object
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class LogicalDatabaseUsage
        attr_accessor :uuid, :instances

        def initialize(uuid:, instances:)
          @uuid = uuid
          @instances = instances
        end
      end
    end
  end
end
