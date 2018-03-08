# frozen_string_literal: true

module Atlas
  module Peering
    ##
    # class: Atlas::Peering::List - The list command
    class List
      def initialize(proxy)
        @proxy = proxy
        self
      end

      def execute(config, data = {})
        @proxy.list(config.groupId, data).parsed_response
      end
    end
  end
end
