# frozen_string_literal: true

require 'yaml'
require 'logger'
require 'json'
require 'atlas/peering/opts_parser'
require 'atlas/peering/config'
require 'atlas/peering/proxy'
require 'atlas/peering/command_factory'
require 'atlas/peering/list'
require 'atlas/peering/create'

module Atlas
  module Peering
    ##
    # class: AtlasPeering::CLI: The command line interface class
    class CLI
      def self.config_to_data
        { 'vpcId':               Config.vpcId,
          'awsAccountId':        Config.awsAccountId,
          'routeTableCidrBlock': Config.routeTableCidrBlock,
          'containerId':         Config.containerId }
      end

      def self.configure_logger
        logger       = ::Logger.new(STDOUT)
        logger.level = ::Logger::INFO
        logger
      end

      def self.die(logger, exit_code, exception = nil)
        if logger
          logger.error(exception.message)
        else
          STDERR.puts(exception.message)
        end

        exit(exit_code)
      end

      def self.run(arguments)
        exit_code = 1
        logger    = CLI.configure_logger
        options   = OptsParser.parse(arguments)
        command   = options[:command].to_sym

        Config.configure(options[:file])
        proxy = Proxy.new(Config.username, Config.apiKey)

        puts JSON.pretty_generate(CommandFactory.create(command, proxy).execute(Config, CLI.config_to_data))

        return exit_code
      rescue StandardError => e
        CLI.die(logger, 2, e)
      end
    end
  end
end
