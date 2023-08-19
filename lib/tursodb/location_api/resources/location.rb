# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/location/get-locations
#
module Tursodb
  module LocationApi
    module Resources
      class Location
        attr_accessor :symbol, :name

        def initialize(symbol:, name:)
          @symbol = symbol
          @name = name
        end
      end
    end
  end
end
