require 'pier_console_detective_coverage'
require "bundler/setup"
require 'irb'
require "dummy_console/pry"
require 'byebug'
require "pier_console_detective"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def reset_pier_console_detective_to_defaults
  ConsoleDetective.setup do |config|
    config.log_file_name    = "log/console.log"
    config.log_tags         = -> { ENV['USER'] }
    config.log_format       = -> (tag, command) { { tag: tag, command: command } }
    config.tag_memoization  = true
  end
end