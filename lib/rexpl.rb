# rexpl is an interactive bytecode console for the Rubinius VM.
#
# **rexpl** is a sandbox to experiment and play with the [Rubinius](http:://rubini.us)
# Virtual Machine and its bytecode instructions. It comes wrapped in a REPL
# (Read-Eval-Print Loop) à la IRB, so that anytime you can open a terminal,
# fire up **rexpl**, and start playing with instant feedback.
#
module Rexpl
end

require 'rexpl/version'
require 'rexpl/generator_proxy'
require 'rexpl/generator_methods'
require 'rexpl/output'
require 'rexpl/environment'
