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

# Location API
## Resources
require_relative "tursodb/location_api/resources/location"
## Shared
require_relative "tursodb/location_api/shared/result"
## APIs
require_relative "tursodb/location_api/get_all_supported_locations"

# Logical Database API
## Resources
require_relative "tursodb/logical_database_api/resources/database_instance_usage"
require_relative "tursodb/logical_database_api/resources/logical_database_usage"
require_relative "tursodb/logical_database_api/resources/logical_database"
require_relative "tursodb/logical_database_api/resources/usage"
## Shared
require_relative "tursodb/logical_database_api/shared/result"
## APIs
# ..

# Organization API
## Resources
require_relative "tursodb/organization_api/resources/member"
require_relative "tursodb/organization_api/resources/organization"
## Shared
require_relative "tursodb/organization_api/shared/result"
## APIs
require_relative "tursodb/organization_api/get_all_organization_members"
require_relative "tursodb/organization_api/get_all_organizations_for_user"

module Tursodb
  class Error < StandardError; end
end
