# frozen_string_literal: true

require 'fintual/constants'

module Fintual
  module Errors
    # Error definitions for handling wrong requests
    class FintualError < StandardError
      def initialize(message, doc_url = Fintual::Constants::GENERAL_DOC_URL)
        super()
        @message = message
        @doc_url = doc_url
      end

      def message
        "\n#{@message}\n Please check the docs at: #{@doc_url}"
      end

      def to_s
        message
      end
    end

    class InvalidRequestError < FintualError; end
    class LinkError < FintualError; end
    class AuthenticationError < FintualError; end
    class InstitutionError < FintualError; end
    class ApiError < FintualError; end
    class MissingResourceError < FintualError; end
    class InvalidLinkTokenError < FintualError; end
    class InvalidUsernameError < FintualError; end
    class InvalidHolderTypeError < FintualError; end
    class MissingParameterError < FintualError; end
    class EmptyStringError < FintualError; end
    class UnrecognizedRequestError < FintualError; end
    class InvalidDateError < FintualError; end
    class InvalidCredentialsError < FintualError; end
    class LockedCredentialsError < FintualError; end
    class InvalidApiKeyError < FintualError; end
    class UnavailableInstitutionError < FintualError; end
    class InternalServerError < FintualError; end
  end
end
