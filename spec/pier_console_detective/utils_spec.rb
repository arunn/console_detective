require "spec_helper"

RSpec.describe ConsoleDetective::Utils do
  before(:each) do
    [:@logger, :@tag].each do |variable|
      ConsoleDetective::Utils.remove_instance_variable(variable) if ConsoleDetective::Utils.instance_variables.include?(variable)
    end
    reset_pier_console_detective_to_defaults
  end

  it "sets up logger object with default filename" do
    expect(ConsoleDetective::Utils.instance_variables).to be_empty
    logger = ConsoleDetective::Utils.logger
    expect(logger.instance_variable_get(:@logdev).filename).to eq ConsoleDetective.log_file_name
    expect(ConsoleDetective::Utils.instance_variables).to eq [:@logger]
    expect(ConsoleDetective::Utils.logger).to eq logger
  end

  it "sets up logger object with overriden filename" do
    ConsoleDetective.setup do |config|
      config.log_file_name = 'log/test_console.log'
    end
    expect(ConsoleDetective::Utils.instance_variables).to be_empty
    logger = ConsoleDetective::Utils.logger
    expect(logger.instance_variable_get(:@logdev).filename).to eq "log/test_console.log"
  end

  it "gets tag based on default config setup and is memoized" do
    expect(ConsoleDetective::Utils.instance_variables).to be_empty
    expect(ConsoleDetective::Utils.get_tag).to eq "#{ENV['USER']}"
    ConsoleDetective.setup do |config|
      config.log_tags = -> { 'nothing' }
    end
    expect(ConsoleDetective::Utils.get_tag).to eq "#{ENV['USER']}"
  end

  it "gets tag based on modified setup and no memoization" do
    expect(ConsoleDetective::Utils.instance_variables).to be_empty
    expect(ConsoleDetective::Utils.get_tag).to eq "#{ENV['USER']}"
    ConsoleDetective.setup do |config|
      config.tag_memoization = false
      config.log_tags = -> { 'nothing' }
    end
    expect(ConsoleDetective::Utils.get_tag).to eq "nothing"
  end

  it "calls logger with tag and command in a thread if immediately is false" do
    logger = ConsoleDetective::Utils.logger
    expect(logger).to receive(:info).with({tag: ENV['USER'], command: 'command_test'})
    thr = ConsoleDetective::Utils.log_command("command_test")
    expect(thr).to be_a(Thread)
    thr.join
    while(thr.alive?)
      sleep(0.1)
    end
  end

  it "calls logger with tag and command if immediately is true" do
    logger = ConsoleDetective::Utils.logger
    expect(logger).to receive(:info).with({tag: ENV['USER'], command: 'command_test'})
    thr = ConsoleDetective::Utils.log_command("command_test", immediately: true)
    expect(thr).not_to be_a(Thread)
  end
end