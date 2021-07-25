require "fiber"
require "pry"

module DummyConsole
  class PryWrapper
    class Input
      def readline
        Fiber.yield
      end
    end

    class Output
      def initialize
        @buffer = ""
      end

      def read_buffer
        @buffer
      ensure
        @buffer = ""
      end

      def print(*args)
        @buffer << args.join(' ')
      end
    end

    def initialize(binding)
      @fiber = Fiber.new do
        @pry.repl(binding)
      end
      @input = DummyConsole::PryWrapper::Input.new
      @output = DummyConsole::PryWrapper::Output.new
      @pry = Pry.new(input: @input, output: @output)
      @fiber.resume
    end

    def send_input(str)
      @fiber.resume("#{str}")
      [@output.read_buffer, []]
    end
  end
end
