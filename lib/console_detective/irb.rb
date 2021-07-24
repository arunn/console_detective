module ConsoleDetective
  module IrbLogger
    def evaluate(*args)
      ConsoleDetective::Utils.log_command(args.first.chomp)
      super(*args)
    end
  end
end

IRB::Context.prepend(ConsoleDetective::IrbLogger) if defined?(IRB::Context)