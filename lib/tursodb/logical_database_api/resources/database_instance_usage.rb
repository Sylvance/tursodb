# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/#database-instance-usage-object
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class DatabaseInstanceUsage
        attr_accessor :uuid, :usage

        def initialize(uuid:, usage:)
          @uuid = uuid
          @usage = usage
        end
      end
    end
  end
end
