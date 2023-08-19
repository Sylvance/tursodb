# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/organization/#organization-object
#
module Tursodb
  module OrganizationApi
    module Resources
      class Organization
        attr_accessor :slug, :name, :type

        def initialize(slug:, name:, type:)
          @slug = slug
          @name = name
          @type = type
        end
      end
    end
  end
end
