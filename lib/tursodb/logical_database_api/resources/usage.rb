# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/#usage-object
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class Usage
        attr_accessor :rows_read, :rows_written, :storage_bytes

        def initialize(rows_read:, rows_written:, storage_bytes:)
          @rows_read = rows_read
          @rows_written = rows_written
          @storage_bytes = storage_bytes
        end
      end
    end
  end
end
