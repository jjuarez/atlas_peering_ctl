# frozen_string_literal: true

require 'json'
require 'atlas/peering/opts_parser'
require 'atlas/peering/config'
require 'atlas/peering/logger'
require 'atlas/peering/client'
require 'atlas/peering/commander'

module Atlas
  module Peering
    ##
    # class: Atlas::Peering::CLI: The command line interface class
    class CLI
      def self.die(logger, exit_code, exception = nil)
        if logger
          logger.error(exception.backtrace)
        else
          STDERR.puts(exception.backtrace)
        end

        exit(exit_code)
      end

      def self.run(arguments)
        options = OptsParser.parse(arguments)
        logger  = Logger.configure(options[:loglevel])

        logger.debug("Load the configuration from file: #{options[:file]}")
        Config.configure(options[:file])

        logger.debug('Creating the Atlas MongoDB client...')
        client   = Client.new(Config.user_name, Config.api_key, Config.group_id, options[:debug])
        response = Commander.new(client, logger).launch(options[:command], Config)

        puts(::JSON.pretty_generate(response))
      rescue StandardError => e
        CLI.die(logger, 2, e)
      end
    end
  end
end
