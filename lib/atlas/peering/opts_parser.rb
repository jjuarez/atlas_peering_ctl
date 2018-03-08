# frozen_string_literal: true

require 'optparse'
require 'logger'

module Atlas
  module Peering
    ##
    # class: AtlasPeering::OptionParser: The command arguments parser
    class OptsParser
      def self.parse(_arguments, defaults = { loglevel: ::Logger::INFO })
        options = defaults
        parser  = OptionParser.new do |opts|
          opts.banner = 'Usage: atlaspeeringctl'

          opts.on('-f', '--configfile CONFIG FILE', String, 'The peering config file') do |f|
            options[:file] = f
          end

          opts.on('-l', '--loglevel LEVEL', String, 'The log level') do |l|
            options[:loglevel] = l
          end

          opts.on('-C', '--command COMMAND', String, 'The command to execute {list, create}') do |c|
            options[:command] = c
          end

          opts.on_tail('-h', '--help', 'Show this message') do
            puts opts
            exit 0
          end
        end

        parser.parse!
        raise ::OptionParser::MissingArgument.new('The config file argument is mandatory') unless options[:file]
        options
      end
    end
  end
end
