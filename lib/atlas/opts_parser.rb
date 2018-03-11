# frozen_string_literal: true

require 'optparse'
require 'logger'
require 'atlas/version'

module Atlas
  ##
  # class: Atlas::OptsParser: The command arguments parser
  class OptsParser
    def self.parse(_arguments, defaults = { loglevel: :info, debug: false })
      options = defaults
      parser  = OptionParser.new do |opts|
        opts.banner = 'Usage: atlaspeeringctl'

        opts.on('-d', '--debug', 'Trace the HTTP calls') do |d|
          options[:debug] = d
        end

        opts.on('-v', '--version', 'Show the version of the application') do
          STDOUT.puts("Atlas peering CTL version: #{Atlas::VERSION}")
          exit(0)
        end

        opts.on('-l', '--loglevel=LEVEL', String, 'The log level') do |l|
          options[:loglevel] = l.downcase.to_sym
        end

        opts.on('-f', '--config=CONFIG_FILE', String, 'The peering config file') do |f|
          options[:file] = f
        end

        opts.on('-C', '--command=COMMAND', String, 'The command to execute {list, create}') do |c|
          options[:command] = c.downcase.to_sym
        end

        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
          exit 0
        end
      end

      parser.parse!
      raise ::OptionParser::MissingArgument.new('The config file argument is mandatory') unless options[:file]
      raise ::OptionParser::MissingArgument.new('The command argument is mandatory') unless options[:command]
      options
    end
  end
end
