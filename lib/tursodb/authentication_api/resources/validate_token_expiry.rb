# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/auth/validate-token-for-user#output
#
module Tursodb
  module AuthenticationApi
    module Resources
      class ValidateTokenExpiry
        attr_accessor :expiry, :token

        def initialize(expiry:, token:)
          @expiry = expiry
          @token = token
        end
      end
    end
  end
end
