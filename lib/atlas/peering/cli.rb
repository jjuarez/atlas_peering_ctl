# frozen_string_literal: true

require 'json'
require 'atlas/peering/opts_parser'
require 'atlas/peering/config'
require 'atlas/peering/logger'
require 'atlas/peering/client'
require 'atlas/peering/commander'

module Atlas
  module Peering
    DEFAULT_ERROR_CODE = 1
    ##
    # class: Atlas::Peering::CLI: The command line interface class
    class CLI
      def self.application_exit(response)
        exit(1) if response.keys.include?('error')
        exit(0)
      end

      def self.run(arguments)
        options = OptsParser.parse(arguments)
        logger  = Logger.configure(options[:loglevel])

        logger.debug("Load the configuration from file: #{options[:file]}")
        Config.configure(options[:file])

        logger.debug('Creating the Atlas MongoDB client...')
        client   = Client.new(Config.user_name, Config.api_key, Config.group_id, options[:debug])
        response = Commander.new(client, logger).launch(options[:command], Config).parsed_response

        puts(JSON.pretty_generate(response))
        CLI.application_exit(response)
      rescue StandardError => exception
        STDERR.puts(exception.backtrace)
        exit(DEFAULT_ERROR_CODE)
      end
    end
  end
end
