module Rexpl
  class Environment
    @@generator = GeneratorProxy.new

    class << self
      # Rexpl's main entry point. Starts the REPL.
      def run
        Output.print_banner
        while (Output.print_prompt; input = gets)
          @@generator.instance_eval input.chomp

          dynamic_method(:run) do |g|
            @@generator.visit(g)
            if g.size == 0
              g.push_nil
            else
              g.show_stack
            end
            g.ret
          end
          new.run
        end
      end
    end
  end
end
