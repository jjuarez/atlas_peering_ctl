module Atlas
  module Peering
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