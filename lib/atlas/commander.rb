# frozen_string_literal: true

module Atlas
  ##
  # class: Atlas::Peering::CommandNotImplemented - The convenient exception
  class CommandNotImplemented < StandardError
  end

  ##
  # class: Atlas::Commander - The command factory class
  class Commander
    def initialize(client)
      @client = client

      self
    end

    def launch(command, data)
      case command
      when :list then
        @client.list(data)
      when :create then
        @client.create(data)
      else
        raise CommandNotImplemented.new(command)
      end
    end
  end
end
