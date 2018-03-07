# frozen_string_literal: true

module Atlas
  module Peering
    ##
    # class: Atlas::Peering::Create - The create command
    class Create
      def initialize(proxy)
        @proxy = proxy
        self
      end

      def execute(config, data)
        @proxy.create(config.groupId, data).parsed_response
      end
    end
  end
end
