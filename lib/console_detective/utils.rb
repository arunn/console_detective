require 'logger'

module ConsoleDetective
  module Utils
    LOGGER_PROC = ->(command) { ConsoleDetective::Utils.logger.info(ConsoleDetective.log_format.call(ConsoleDetective::Utils.get_tag, command)) }

    def self.logger
      @logger ||= Logger.new(ConsoleDetective.log_file_name)
    end

    def self.get_tag
      return @tag if ConsoleDetective.tag_memoization && @tag
      @tag = ConsoleDetective.log_tags.call
    end

    def self.log_command(command, immediately: false)
      return Thread.new { ConsoleDetective::Utils::LOGGER_PROC.call(command) } unless immediately
      ConsoleDetective::Utils::LOGGER_PROC.call(command)
    end
  end
end