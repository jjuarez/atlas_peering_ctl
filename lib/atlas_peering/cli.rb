# frozen_string_literal: true

require 'yaml'
require 'logger'
require 'atlas_peering/option_parser'
require 'atlas_peering/client'

module AtlasPeering
  ##
  # class: AtlasPeering::CLI: The command line interface class
  class CLI
    def self.config_to_data(config)
      { 'vpcId':               config['vpcId'],
        'awsAccountId':        config['awsAccountId'],
        'routeTableCidrBlock': config['routeTableCidrBlock'],
        'containerId':         config['containerId'] }
    end

    def self.configure_logger
      logger       = ::Logger.new(STDOUT)
      logger.level = ::Logger::INFO
      logger
    end

    def self.run(arguments)
      exit_code = 1
      options   = AtlasPeering::Optionparser.parse(arguments)
      config    = ::YAML.load_file(options[:config])
      logger    = AtlasPeering::CLI.configure_logger
      command   = options[:command].to_sym
      client    = AtlasPeering::Client.new(config['username'], config['apiKey'])

      case command
      when :list then
        puts client.list(config['groupId']).parsed_response
        exit_code = 0
      when :create then
        puts client.create(config['groupId'], AtlasPeering::CLI.config_to_data(config)).parsed_response
        exit_code = 0
      else
        logger.error("Command: #{command} unkown")
        exit_code = 1
      end

      return exit_code
    rescue StandardError => e
      logger.error(e.message)
      exit 2
    end
  end
end
