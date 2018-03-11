# frozen_string_literal: true

module Atlas
  ##
  # class: Atlas::Peering::Logger: The application logger
  class Logger
    LOG_LEVELS = {
      debug: ::Logger::DEBUG,
      info:  ::Logger::INFO,
      warn:  ::Logger::WARN,
      error: ::Logger::ERROR
    }.freeze

    def self.configure(level, target = STDOUT)
      logger       = ::Logger.new(target)
      logger.level = LOG_LEVELS.fetch(level, ::Logger::INFO)

      logger
    end
  end
end
