# frozen_string_literal: true

require 'httparty'
require 'json'

module Atlas
  module Peering
    ##
    # class: AtlasPeering::Client: The Atlas MongoDB client interface
    class Proxy
      include HTTParty

      DEFAULT_ATLAS_URL   = 'https://cloud.mongodb.com/api/atlas/v1.0'
      CONTENT_TYPE_HEADER = { 'Content-Type': 'application/json' }.freeze

      base_uri DEFAULT_ATLAS_URL

      def self.build(arguments = {})
        Atlas::Client.new(arguments[:username], arguments[:password])
      end

      def initialize(username, password)
        @auth = { username: username, password: password }
      end

      def basic_options
        { headers:     CONTENT_TYPE_HEADER,
          digest_auth: @auth }
      end

      def list(group_id, data = {})
        options = basic_options

        self.class.get("/groups/#{group_id}/peers", options)
      end

      def create(group_id, data)
        options        = basic_options
        options[:body] = data.to_json

        self.class.post("/groups/#{group_id}/peers", options)
      end
    end
  end
end
