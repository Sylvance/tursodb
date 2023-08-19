# frozen_string_literal: true

# Docs:
# https://docs.turso.tech/reference/platform-rest-api/#about-the-examples-in-this-documentation
#
module Tursodb
  class Configuration
    attr_accessor :base_url, :token

    def initialize
      @base_url = "https://api.turso.tech"
      @token = nil
    end

    def authenticate_with_token(token)
      @token = token
    end

    def authenticated?
      !@token.nil?
    end
  end
end
