# frozen_string_literal: true

require 'http'
require 'fintual/errors'
require 'fintual/constants'
require 'fintual/version'
require 'fintual/resources/goal'
require 'json'
require 'net/http'
require 'net/https'

module Fintual
  # Client component to make the requests and get data
  class Client
    def initialize(email, password)
      @email = email
      @password = password
      @user_agent = "fintual-ruby/#{Fintual::VERSION}"
      @headers = {
        'Content-Type': 'application/json',
        'User-Agent': @user_agent
      }
      @default_params = {}
      @default_params = {
        user_email: @email,
        user_token: get_token
      }
    end

    def get
      request('get')
    end

    def delete
      request('delete')
    end

    def request(method)
      proc do |resource, **kwargs|
        parameters = params(method, **kwargs)
        response = make_request(method, resource, parameters)
        content = JSON.parse(response.body, symbolize_names: true)
        data = content[:data]
        error = content[:error]

        if content[:status] == "error"
          raise_custom_error(content)
        end
        data
      end
    end

    def goals
      result = get.call('goals')
      result.map { |data| build_goal(data[:attributes]) }
    end

    def build_goal(**kwargs)
      Fintual::Goal.new(**kwargs)
    end

    def to_s
      visible_chars = 4
      hidden_part = '*' * (@api_key.size - visible_chars)
      visible_key = @api_key.slice(0, visible_chars)
      "Client(🔑=#{hidden_part + visible_key}"
    end

    private

    def client
      @client ||= Net::HTTP
    end

    def make_request(method, resource, parameters)
      uri = URI.parse("#{Fintual::Constants::SCHEME}#{Fintual::Constants::BASE_URL}#{resource}")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      case method.downcase
      when 'get'
        req = Net::HTTP::Get.new(uri.path, @headers)
      when 'post'
        req = Net::HTTP::Post.new(uri.path, @headers)
      end
      req.body = parameters.to_json
      https.request(req)
    end

    def params(method, **kwargs)
      { **@default_params, **kwargs }

    end

    def raise_custom_error(error)
      raise Fintual::Errors::FintualError.new(error[:message])
    end

    def get_token
      payload = {
        user: {email: @email, password: @password}
        }
      request('post').call('access_tokens', payload)[:attributes][:token]
    end
  end
end
