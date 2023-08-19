# frozen_string_literal: true

require_relative "tursodb/configuration"
require_relative "tursodb/errors"
require_relative "tursodb/version"

# Authentication API
## Resources
require_relative "tursodb/authentication_api/resources/platform_api_token"
require_relative "tursodb/authentication_api/resources/validate_token_expiry"
## Shared
require_relative "tursodb/authentication_api/shared/result"
## APIs
require_relative "tursodb/authentication_api/get_all_platform_api_tokens"
require_relative "tursodb/authentication_api/mint_platform_api_token_for_user"
require_relative "tursodb/authentication_api/revoke_platform_api_token_for_user"
require_relative "tursodb/authentication_api/validate_platform_api_token"

module Tursodb
  class Error < StandardError; end
end
