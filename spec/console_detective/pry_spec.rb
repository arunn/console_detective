require "spec_helper"

RSpec.describe "ConsoleDetective::Pry" do
  let(:fresh_binding) {
    local_a = 123
    binding
  }

  let(:repl) { 
    DummyConsole::PryWrapper.new fresh_binding 
  }

  it "calls log command when before_eval is called" do
    random_string = "random_string_pry"
    expect(ConsoleDetective::Utils).to receive(:log_command).with("puts '#{random_string}'")
    repl.send_input("puts '#{random_string}'")
  end

  it "calls log command when after_session is called" do
    expect(ConsoleDetective::Utils).to receive(:log_command).with("exit", immediately: true)
    repl.send_input("exit-all")
  end
end