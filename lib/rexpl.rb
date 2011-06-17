# Rexpl is an interactive bytecode console for the Rubinius VM.
#
# It intends to be a fun tool to use when learning how to use Rubinius
# bytecodes, for example when bootstraping a new language targeting the
# Rubinius VM.
#
# Implemented as a REPL-like executable (think of it as an IRB for Rubinius
# bytecode), Rexpl accepts any command that can be issued to an instance of
# Rubinius::Generator, plus some custom commands to list the current program
# instructions or print out the state of the stack after each instruction, for
# example.
#
module Rexpl
end

require 'rexpl/version'
require 'rexpl/generator_proxy'
require 'rexpl/generator_methods'
require 'rexpl/output'
require 'rexpl/environment'
