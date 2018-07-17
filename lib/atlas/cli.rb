# frozen_string_literal: true

require 'json'
require 'thor'
require 'atlas/config'
require 'atlas/client'

module Atlas
  DEFAULT_ERROR_CODE = 1
  LIST_ERROR_CODE    = 2
  CREATE_ERROR_CODE  = 3
  DELETE_ERROR_CODE  = 4

  ##
  # class: Atlas::CLI: The command line interface class
  class Peering < ::Thor
    no_commands do
      def handle_exit(response, exit_code = DEFAULT_ERROR_CODE)
        if response.keys.include?('error')
          exit(exit_code)
        else
          exit(0)
        end
      end

      def out(response)
        STDOUT.puts(::JSON.pretty_generate(response))
      end

      def die(exception, error_code)
        STDERR.puts(exception.backtrace)
        exit(error_code)
      end
    end

    desc 'version', 'Atlas peering CTL version'
    def version
      puts Atlas::VERSION
    end

    desc 'list', 'List all the Atlas MongoDB peerings for the configuration given'
    option :config, required: true, type: :string, aliases: ['-f'], desc: 'The VPC identificator to make the peering'
    def list
      Config.configure(options[:config])

      client   = Client.new(Config.user_name, Config.api_key, Config.group_id)
      response = client.list(Config).parsed_response
      out(response)
      handle_exit(response)
    rescue StandardError => exception
      die(exception, LIST_ERROR_CODE)
    end

    desc 'create', 'Create a new Atlas MongoDB peering connection based on the configuration given'
    option :config, required: true, type: :string, aliases: ['-f'], desc: 'The VPC identificator to make the peering'
    option :vpcid, required: true, type: :string, desc: 'The VPC identificator to make the peering'
    def create()
      Config.configure(options[:config])
      Config.configure.vpc_id = options[:vpcid]

      client   = Client.new(Config.user_name, Config.api_key, Config.group_id)
      response = client.create(Config).parsed_response
      out(response)
      handle_exit(response)
    rescue StandardError => exception
      die(exception, CREATE_ERROR_CODE)
    end

    desc 'delete', 'Delete a Atlas MongoDB peering connection based on the configuration given'
    option :config, required: true, type: :string, aliases: ['-f'], desc: 'The VPC identificator to make the peering'
    def delete(id)
      Config.configure(options[:config])
      Config.configure { |c| c.id = id }

      client   = Client.new(Config.user_name, Config.api_key, Config.group_id)
      response = client.delete(Config).parsed_response
      handle_exit(response)
    rescue StandardError => exception
      die(exception, DELETE_ERROR_CODE)
    end
  end
end
