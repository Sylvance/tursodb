# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/database/create-database-in-org
#
module Tursodb
  module LogicalDatabaseApi
    module Resources
      class Credentials
        attr_accessor :username, :password

        def initialize(username:, password:)
          @username = username
          @password = password
        end
      end
    end
  end
end
