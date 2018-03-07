module Atlas
  module Peering
    ##
    # class: Atlas::Peering::CommandFactory: The command factory class
    class CommandFactory
      def self.create(command, proxy)
        case command
        when :list then
          List.new(proxy)
        when :create then
          Create.new(proxy)
        else
          raise StandardError.new("Command: #{command} unknown")
        end
      end
    end
  end
end
