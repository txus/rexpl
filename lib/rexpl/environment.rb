module Rexpl
  class Environment
    @@generator = Rexpl::GeneratorProxy.new

    def self.run
      puts "\nRbx bytecode REPL. Kind of."
      puts "---------------------------\n"
      puts "\nJust enter generator instructions.\n'reset' to reset, 'list' to list the current program instructions, 'draw' to print.\n"
      while (print '> '; input = gets)
        @@generator.instance_eval input.chomp

        dynamic_method(:run) do |g|
          @@generator.visit(g)
          if @@generator.instructions.any?
            g.show_stack
          else
            g.push_nil
          end
          g.ret
        end
        new.run
      end
    end
  end
end
