require "spec_helper"

RSpec.describe ConsoleDetective do
  before(:each) do
    reset_pier_console_detective_to_defaults
  end

  it "has a version number" do
    expect(ConsoleDetective::VERSION).not_to be nil
  end

  it "has a fixed version number" do
    expect(ConsoleDetective::VERSION).to eq "0.1.2"
  end

  it "has meaningul defaults set" do
    expect(ConsoleDetective.log_file_name).to eq "log/console.log"
    expect(ConsoleDetective.log_tags.call).to eq "#{ENV['USER']}"
    expect(ConsoleDetective.log_format.call('tag_test', 'command_test')).to eq({tag: "tag_test", command: 'command_test'})
    expect(ConsoleDetective.tag_memoization).to eq true
  end

  it "is possible to override defaults with setup" do
    ConsoleDetective.setup do |config|
      config.log_file_name = 'log/test_console.log'
      config.log_tags = -> { 'test_tag' }
      config.log_format = -> (tag, command) { "#{tag}----#{command}"  }
      config.tag_memoization = false
    end

    expect(ConsoleDetective.log_file_name).to eq "log/test_console.log"
    expect(ConsoleDetective.log_tags.call).to eq "test_tag"
    expect(ConsoleDetective.log_format.call('tag_test', 'command_test')).to eq("tag_test----command_test")
    expect(ConsoleDetective.tag_memoization).to eq false
  end
end
