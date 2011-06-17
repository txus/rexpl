module Rexpl
  # This class acts as a Proxy between the user and an actual Generator.
  #
  class GeneratorProxy
    protected_methods = %w(class to_s inspect instance_eval tainted?)
    # Undefine every method so that this class acts as an actual proxy.
    instance_methods.each do |method|
      unless method.to_s =~ /^_/ || protected_methods.include?(method.to_s)
        undef_method method
      end
    end

    attr_accessor :instructions

    # Initializes a new {GeneratorProxy} instance with an empty instruction
    # set.
    def initialize
      @instructions = []
    end

    # Swallows every message passed onto the instance and stores it in the
    # instruction set.
    def method_missing(method, *args)
      @instructions << [method, *args]
      nil
    end

    # Applies the set of instructions to an actual generator.
    #
    # It captures errors in case an instruction is unknown or called with wrong
    # arguments.
    #
    # @param [Rubinius::Generator] generator the generator onto which apply the
    #   instructions.
    #
    # @example
    #
    #   proxy = Rexpl::GeneratorProxy.new
    #   proxy.push 83
    #   proxy.push_literal 'bar'
    #
    #   dynamic_method(:foo) do |g|
    #     proxy.visit(g)
    #     g.ret
    #   end
    #     
    def visit(generator)
      last_instruction = nil
      begin
        @instructions.each do |instruction|
          last_instruction = instruction
          generator.__send__ *instruction
        end
      rescue NameError, ArgumentError=>e
        puts "[ERROR]: #{e}"
        @instructions.delete(last_instruction)
      end
    end

    # Empties the instruction set.
    def reset
      Output.print_reset
      initialize
    end

    # Prints a list of the current instruction set.
    def list
      puts
      @instructions.each_with_index do |instruction, idx|
        Output.print_instruction instruction, idx
      end
      puts
    end

    # Visually represents the state of the stack after each instruction is ran.
    def draw
      instructions = @instructions.dup
      klass = Class.new do
        dynamic_method(:draw) do |g|

          instructions.each_with_index do |instruction, idx|
            # Execute the instruction
            before = g.size
            g.__send__ *instruction
            after = g.size

            # Print the instruction header
            produced = after - before
            verb = 'produced'
            if produced < 0
              verb = 'consumed'
              produced = produced.abs
            end
            g.push_self
            g.push_literal "[#{idx}] [#{instruction.first} #{instruction[1..-1].map(&:inspect).join(', ')}] #{verb} #{produced} stack, size is now #{after}"
            g.send :puts, 1, true
            g.pop

            # Visually print the entire stack
            g.return_stack
            g.push_const :Rexpl
            g.find_const :Output
            g.swap_stack
            g.send :print_stack, 1, true
            g.pop
          end

          g.push_nil
          g.ret
        end
      end

      klass.new.draw
    end
  end
end
