module Rexpl
  # This class represents the Environment holding a {GeneratorProxy} instance
  # exposing the main entry point as a class method.
  #
  class Environment
    @@generator = GeneratorProxy.new

    class << self
      # Fires up the REPL. This is the program's main entry point.
      def run
        Output.print_banner

        while (Output.print_prompt; input = gets)
          @@generator.instance_eval input.chomp

          # After each new instruction, evaluate all of them.
          dynamic_method(:run) do |g|
            @@generator.visit(g)
            if g.size == 0
              g.push_nil
            else
              g.print_debug_info
            end
            g.ret
          end
          new.run
        end
      end
    end
  end
end
