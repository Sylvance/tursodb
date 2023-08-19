# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/#about-the-examples-in-this-documentation
#
module Tursodb
  class Errors
    UNAUTHORIZED_ERROR_MESSAGE = "Unauthorized - ensure that the auth token is present and valid"
    PAYMENT_REQUIRED_ERROR_MESSAGE = "Payment required - organization feature is not part of account plan"
    RESOURCE_CONFLICT_ERROR_MESSAGE = "Conflict - resource already exists"
    SERVER_ERROR_MESSAGE = "Server Error - tursodb is down"
    UNKNOWN_ERROR_MESSAGE = "Unknown error occurred"
  end
end
