require 'test_helper'

class GeneratorMethodsTest < MiniTest::Unit::TestCase

  def test_print_debug_info
    klass = Class.new do
      dynamic_method :foo do |g|
        g.push 5
        g.push 6
        g.print_debug_info
        g.ret
      end
    end
    Rexpl::Output.expects(:print_debug_info).with(2, '6')
    result = klass.new.foo
    assert_equal result, 6
  end

  def test_return_stack_returns_an_array_with_stack_cells
    klass = Class.new do
      dynamic_method :foo do |g|
        g.push 3
        g.push 6
        g.return_stack
        g.ret
      end
    end
    assert_equal klass.new.foo, [3, 6]
  end

  def test_size_returns_size_of_the_stack
    g = Rubinius::Generator.new
    g.push 3
    g.push 5
    assert_equal 2, g.size
  end

end
