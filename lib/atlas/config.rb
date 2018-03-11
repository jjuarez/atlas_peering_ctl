# frozen_string_literal: true

require 'yaml'

module Atlas
  ##
  # class: Atlas::Config: This class helps to handle configuration from YAML files
  module Config
    @config = nil

    def self.init
      @config ||= {}
    end

    def self.configure(source = nil)
      @config || Config.init

      case source
      when /\.(yml|yaml)$/i then
        raise StandardError.new("The configuration file: #{config_file} does not exist") unless File.exist?(source)

        @config = ::YAML.safe_load(File.read(source))
      else
        yield self if block_given?
      end

      self
    end

    def self.inspect
      @config || Config.init
      @config.inspect
    end

    def self.[](key)
      @config || Config.init
      @config[key]
    end

    def self.fetch(key, default_value = nil)
      @config || Config.init
      if @config.keys.include?(key)
        @config[key]
      else
        default_value
      end
    end

    def self.respond_to_missing?
      true
    end

    def self.method_missing(method, *arguments, &block)
      @config || Config.init

      method_str = method.to_s

      case method_str
      when /(.+)=$/ then
        key          = method_str.delete('=').to_sym
        @config[key] = arguments.size == 1 ? arguments[0] : arguments
      when /(.+)\?$/ then
        key = method_str.delete('?').to_sym
        @config.keys.include?(key)
      else
        if @config.keys.include?(method)
          @config[method]
        elsif @config.keys.include?(method_str)
          @config[method_str]
        else
          super
        end
      end
    end
  end
end
