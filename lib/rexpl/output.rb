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

      def print_prompt
        print bold { '> ' }
      end

      private

      def print_rationale
        puts "To start playing, just start typing some Rubinius VM instructions."
        puts "You can find a complete list with documentation here:"
        puts
        puts "\thttp://rubini.us/doc/en/virtual-machine/instructions/"
        puts
        puts "To introspect the program you are writing, use the following commands:"
        puts
        puts "  " + bold { "list" } + " lists the instruction set of the current program."
        puts "  " + bold { "reset" } + " empties the instruction set and starts a new program."
        puts "  " + bold { "draw" } + " prints a visual representation of the stack after each instruction."
        puts
      end
    end
  end
end
