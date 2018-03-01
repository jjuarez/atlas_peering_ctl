require 'atlas_peering/option_parser'
require 'yaml'
require 'rest-client'


module AtlasPeering
  class CLI
    DEFAULT_ERROR_CODE = 1
    DEFAULT_COMMAND    = :list

    DEFAULT_URL_PREFIX = 'https://cloud.mongodb.com/api/atlas/v1.0'

    def self.run(arguments)
      parameters = Optionparser.parse(arguments, { command: DEFAULT_COMMAND })
      config     = YAML.load_file(parameters[:config])


    rescue StandardError => e
      $stderr.puts "ERROR: #{e.message}"
      exit DEFAULT_ERROR_CODE
    end
  end
end

