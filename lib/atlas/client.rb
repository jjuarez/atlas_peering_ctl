# frozen_string_literal: true

require 'httparty'
require 'json'

module Atlas
  ##
  # class: Atlas::Client: The Atlas Mclient interface
  class Client
    DEFAULT_ATLAS_URL = 'https://cloud.mongodb.com/api/atlas/v1.0'
    HEADERS           = {
      'Content-Type' => 'application/json',
      'User-Agent'   => 'Httparty'
    }.freeze

    def initialize(user_name, api_key, group_id)
      @headers        = HEADERS
      @user_name      = user_name
      @api_key        = api_key
      @peers_endpoint = "#{DEFAULT_ATLAS_URL}/groups/#{group_id}/peers"

      self
    end

    def basic_options
      {
        headers:     @headers,
        digest_auth: { username: @user_name, password: @api_key }
      }
    end

    def list(_data = {})
      HTTParty.get(@peers_endpoint, basic_options)
    end

    def create(data)
      call_options        = basic_options
      call_options[:body] = {
        "vpcId":               data.vpc_id,
        "awsAccountId":        data.aws_account_id,
        "routeTableCidrBlock": data.route_table_cidr_block,
        "containerId":         data.container_id
      }.to_json

      HTTParty.post(@peers_endpoint, call_options)
    end

    def delete(data)
      HTTParty.delete("#{@peers_endpoint}/#{data.id}", basic_options)
    end
  end
end
