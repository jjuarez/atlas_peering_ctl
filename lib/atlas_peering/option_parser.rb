#!/usr/bin/env ruby

require 'optparse'


module AtlasPeering
  class Optionparser

    def self.parse(arguments, defaults = { })
      options = defaults
      parser  = OptionParser.new do |opts|
        opts.banner = "Usage: atlas_peering"

        opts.on("-c", "--config CONFIG FILE", String, "The peering config file") do |config|
          options[:config] = configº
        end

        opts.on("-C", "--command [COMMAND]", String, "The command to execute") do |command|
          options[:command] = command
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      parser.parse!
      raise ::OptionParser::MissingArgument.new('The config file argument is mandatory') if options[:config].nil?

      options
    end
  end
end

