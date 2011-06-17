require 'ansi'

module Rexpl
  # Utility module to abstract output-related stuff, like printing banners or
  # graphically representing stacks.
  class Output
    extend ANSI::Code

    class << self
      # Prints the welcome banner and a bit of instructions on how to use the
      # interactive console.
      def print_banner
        puts
        puts bold { red { "rexpl" } } + bold { " v#{Rexpl::VERSION}" } + " - interactive bytecode console for Rubinius"
        puts bold { "--------------------------------------------------------" }
        puts
        print_rationale
      end

      # Prints the console prompt.
      def print_prompt
        print bold { '> ' }
      end

      # Prints a message indicating that the instruction set has been resetted.
      def print_reset
        puts "Reseted!"
      end

      # Prints the current size of the stack and the topmost value.
      def print_debug_info(size, value)
        puts "=> [" + bold { "Stack size: #{size}"} + "] " + "[" + bold { "Topmost value: #{value}" } + "]"
      end

      # Prints an instruction in a single row.
      def print_instruction(instruction, idx)
        puts bold { "[" } + blue { idx.to_s } + bold { "]" } + ": " + green { instruction.first } + " " + bold { instruction[1..-1].map(&:inspect) }
      end

      # Prints a stack out of an array of stack cells.
      #
      # @param [Array] cells the cells of the stack containing its values.
      def print_stack(cells)
        puts
        puts "\t#{bold { 'Current stack' }.center(33, ' ')}"
        puts "\t" + blue { "-------------------------" }
        cells.reverse.each do |element|
          puts "\t#{blue {"|"} }#{bold { element.inspect.center(23, ' ') }}#{blue {"|"}}"
          puts "\t" + blue { "-------------------------" }
        end
        puts
      end

      # Prints a little readme to get people started when firing up the
      # interactive console.
      def print_rationale
        puts "To start playing, just start typing some Rubinius VM instructions."
        puts "You can find a complete list with documentation here:"
        puts
        puts "\thttp://rubini.us/doc/en/virtual-machine/instructions/"
        puts
        puts "To introspect the program you are writing, use the following commands,"
        puts "or type " + bold { "exit" } + " to exit:"
        puts
        puts "  " + bold { "list" } + " lists the instruction set of the current program."
        puts "  " + bold { "reset" } + " empties the instruction set and starts a new program."
        puts "  " + bold { "draw" } + " prints a visual representation of the stack after each instruction."
        puts
      end
    end
  end
end
