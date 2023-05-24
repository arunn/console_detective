if defined?(Pry)
  Pry.hooks.add_hook(:before_eval, "log_before_eval") do |command, _pry|
    ConsoleDetective::Utils.log_command(command.chomp)
  end

  Pry.hooks.add_hook(:after_session, "log_after_session") do |_output, _binding, _pry|
    ConsoleDetective::Utils.log_command("exit", immediately: true)
  end
end
