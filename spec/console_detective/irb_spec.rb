require "spec_helper"

RSpec.describe "ConsoleDetective::Irb" do
  it "calls log command when evaluate is called" do
    random_string = "random_string_irb"
    expect(ConsoleDetective::Utils).to receive(:log_command).with("puts '#{random_string}';exit")
    File.open('tmp/commands.rb', 'w') {|file| file.truncate(0) }
    File.open("tmp/commands.rb", "w+") {|f| f.write("puts '#{random_string}';exit") }
    IRB.conf[:SCRIPT] = "tmp/commands.rb"
    argv = ARGV.dup
    ARGV.clear # We are clearing arguments sent for rspec
    expect { IRB.start(__FILE__) }.to output(/#{random_string}\n$/).to_stdout # Should end with the string that we print. Not any exceptions.
  ensure
    File.open('tmp/commands.rb', 'w') {|file| file.truncate(0) }
    ARGV.replace(argv)
  end
end