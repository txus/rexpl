module Rexpl
  class GeneratorProxy
    protected_methods = %w(class to_s inspect instance_eval tainted?)
    instance_methods.each { |method| undef_method method unless method.to_s =~ /^_/ || protected_methods.include?(method.to_s)}
    attr_accessor :instructions

    def initialize
      @instructions = []
    end

    def reset
      puts 'Reseted!'
      initialize
    end

    def list
      puts
      @instructions.each_with_index do |instruction, idx|
        puts "[#{idx}]: #{instruction.first} #{instruction[1..-1].map(&:inspect)}"
      end
      puts
    end

    def draw

      instructions = @instructions.dup
      klass = Class.new do
        def print_stack(arr)
          puts "\n\t#{'Current stack'.center(25, ' ')}"
          puts "\t-------------------------" 
          arr.reverse.each do |element|
            puts "\t|#{element.inspect.center(23, ' ')}|"
            puts "\t-------------------------" 
          end
          puts "\n"
          nil
        end
        dynamic_method(:draw) do |g|

          g.push :self
          g.push_literal "\n"
          g.send :puts, 1, true
          g.pop

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

            # Print the entire stack
            g.return_stack
            g.push_self
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

    def method_missing(m, *args)
      @instructions << [m, *args]
      nil
    end

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
      !!@instructions.any?
    end
  end
end
