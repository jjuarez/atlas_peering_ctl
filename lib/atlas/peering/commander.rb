# frozen_string_literal: true

module Atlas
  module Peering
    ##
    # class: Atlas::Peering::CommandNotImplemented - The convenient exception
    class CommandNotImplemented < StandardError
    end

    ##
    # class: Atlas::Peering::Commander - The command factory class
    class Commander
      def initialize(client, logger = nil)
        @client = client
        @logger = logger

        self
      end

      def launch(command, data)
        case command
        when :list then
          @logger&.debug('Launching LIST command')
          @client.list(data)
        when :create then
          @logger&.debug('Launching CREATE command')
          @client.create(data)
        else
          raise CommandNotImplemented.new(command)
        end
      end
    end
  end
end
