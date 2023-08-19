# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/auth/#platform-api-token-object
#
module Tursodb
  module AuthenticationApi
    module Resources
      class PlatformApiToken
        attr_accessor :id, :name, :token

        def initialize(id:, name:, token: nil)
          @id = id
          @name = name
          @token = token
        end
      end
    end
  end
end
