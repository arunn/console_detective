require "pier_console_detective/version"
require "pier_console_detective/mod_attr_accessor"

module ConsoleDetective
  extend ConsoleDetective::ModAttrAccessor

  def self.setup
    yield self
  end

  # log_file_name is a string/file that mentions the location and name of the file where log will be written.
  # default value is log/console.log
  mod_attr_accessor :log_file_name, "log/console.log"

  # log_tags is a lambda outputting the tag to tag the log entry
  # default value is the ENV['USER']
  mod_attr_accessor :log_tags, -> { ENV['USER'] }

  # log_format is a lambda which takes tag and command as input and outputs the format in which the log will be entered in the log file
  # default format is a hash of format { :tag => <tag>, :command => <command> }
  mod_attr_accessor :log_format, -> (tag, command) { { tag: tag, command: command } }
  
  # tag_memoization is a boolean to mention if the tag should be memoized or not.
  # default is true
  mod_attr_accessor :tag_memoization, true
end

require 'pier_console_detective/utils'
require 'pier_console_detective/irb'
require 'pier_console_detective/pry'
