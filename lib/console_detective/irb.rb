module ConsoleDetective
  module IrbLogger
    def evaluate(*args, **kw)
      ConsoleDetective::Utils.log_command(args.first.chomp)
      super(*args, **kw)
    end
  end
end

IRB::Context.prepend(ConsoleDetective::IrbLogger) if defined?(IRB::Context)