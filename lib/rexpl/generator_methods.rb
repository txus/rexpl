module Rexpl
  # Extends the Rubinius::Generator class with some utility methods used by
  # Replx.
  #
  module GeneratorMethods
    # Prints the topmost element on the stack and the stack's current size.
    #
    # Calling this method neither consumes nor produces stack, it's just used
    # for debugging the current state.
    def print_debug_info
      initial_size = size
      dup
      push_const :Rexpl
      find_const :Output
      swap_stack
      send :inspect, 0, true
      push_literal initial_size
      swap_stack
      send :print_debug_info, 2, true 
      pop
    end

    # Returns an array with all the elements currently in the stack.
    #
    # Calling #return_stack increases by 1 the stack size (being the topmost
    # element an array containing a duplicate of every other element in the
    # stack).
    def return_stack
      initial_size = size
      dup_many initial_size
      make_array initial_size
    end

    # Returns the current size of the stack.
    #
    # @return [Fixnum] the current size of the stack.
    def size
      @current_block.instance_eval { @stack }
    end
  end
end

Rubinius::Generator.__send__ :include, Rexpl::GeneratorMethods
