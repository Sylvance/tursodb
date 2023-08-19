# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/#logical-database-object
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class LogicalDatabase
        attr_accessor :name, :hostname, :issued_cert_limit, :issued_cert_count, :db_id, :regions, :primary_region, :type

        def initialize(name:, hostname:, issued_cert_limit:, issued_cert_count:, db_id:, regions:, primary_region:,
                       type:)
          @name = name
          @hostname = hostname
          @issued_cert_limit = issued_cert_limit
          @issued_cert_count = issued_cert_count
          @db_id = db_id
          @regions = regions
          @primary_region = primary_region
          @type = type
        end
      end
    end
  end
end
