module Atlas
  module Peering
    class List
      def initialize(proxy)
        @proxy = proxy
        self
      end

      def execute(config, data = {})
        @proxy.list(config.groupId).parsed_response
      end
    end
  end
end
