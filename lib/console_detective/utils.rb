require 'logger'

module ConsoleDetective
  module Utils
    def self.logger
      @logger ||= Logger.new(ConsoleDetective.log_file_name)
    end

    def self.get_tag
      return @tag if ConsoleDetective.tag_memoization && @tag
      @tag = ConsoleDetective.log_tags.call
    end

    def self.log_command(command)
      Thread.new { ConsoleDetective::Utils.logger.info(ConsoleDetective.log_format.call(command)) }
    end
  end
end