# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/organization/#organization-member-object
#
module Tursodb
  module OrganizationApi
    module Resources
      class Member
        attr_accessor :username, :role

        def initialize(username:, role:)
          @username = username
          @role = role
        end
      end
    end
  end
end
