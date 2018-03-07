# frozen_string_literal: true

require 'httparty'
require 'json'

module AtlasPeering
  ##
  # class: AtlasPeering::Client: The Atlas MongoDB client interface
  class Client
    include HTTParty

    base_uri 'https://cloud.mongodb.com/api/atlas/v1.0'

    def initialize(username, password)
      @auth = { username: username, password: password }
    end

    def list(group_id)
      options = { digest_auth: @auth }
      self.class.get("/groups/#{group_id}/peers", options)
    end

    def create(group_id, data)
      options = {
        headers: { 'Content-Type': 'application/json' },
        digest_auth: @auth,
        body: data.to_json
      }

      self.class.post("/groups/#{group_id}/peers", options)
    end
  end
end
