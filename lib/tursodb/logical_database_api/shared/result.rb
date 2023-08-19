# frozen_string_literal: true

require "json"

# Shared result class
#
module Tursodb
  module LocationApi
    module Shared
      class Result
        attr_accessor :response, :result_klass, :error_result_klass

        def initialize(response, result_klass, error_result_klass)
          @response = response
          @result_klass = result_klass
          @error_result_klass = error_result_klass
        end

        def call
          case response.code.to_i
          when 200
            parse_response(response)
          when 401
            error_result_klass.new(response, Tursodb::Errors::UNAUTHORIZED_ERROR_MESSAGE)
          when 402
            error_result_klass.new(response, Tursodb::Errors::PAYMENT_REQUIRED_ERROR_MESSAGE)
          when 409
            error_result_klass.new(response, Tursodb::Errors::RESOURCE_CONFLICT_ERROR_MESSAGE)
          when 500
            error_result_klass.new(response, Tursodb::Errors::SERVER_ERROR_MESSAGE)
          else
            error_result_klass.new(response, Tursodb::Errors::UNKNOWN_ERROR_MESSAGE)
          end
        end

        private

        def parse_response(response)
          result_klass.new(JSON.parse(response.body))
        rescue ArgumentError
          result_klass.new(JSON.parse(response.body), response.token)
        end
      end
    end
  end
end
