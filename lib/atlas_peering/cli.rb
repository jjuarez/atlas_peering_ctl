require 'yaml'
require 'ap'
require 'atlas_peering/option_parser'
require 'atlas_peering/client'


module AtlasPeering
  class CLI
    DEFAULT_ERROR_CODE = 1

    def self.config_to_data(config)
      { "vpcId"               =>"#{config['vpcId']}",
        "awsAccountId"        =>"#{config['awsAccountId']}",
        "routeTableCidrBlock" =>"#{config['routeTableCidrBlock']}",
        "containerId"         =>"#{config['containerId']}"
      }
    end

    def self.run(arguments)
      options = AtlasPeering::Optionparser.parse(arguments)
      config  = ::YAML.load_file(options[:config])
      command = options[:command].to_sym
      client  = AtlasPeering::Client.new(config['username'], config['apiKey'])

      case command
        when :list then
          ap client.list(config['groupId']).parsed_response
        when :create then
          data = AtlasPeering::CLI.config_to_data(config)
          ap client.create(config['groupId'], data).parsed_response
        else $stderr.puts("Command unkown")
      end
    rescue StandardError => e
      $stderr.puts "ERROR: #{e.message}"
      exit DEFAULT_ERROR_CODE
    end
  end
end
