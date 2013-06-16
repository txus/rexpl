require 'test_helper'

class GeneratorProxyTest < MiniTest::Unit::TestCase
  def setup
    $stdout = StringIO.new
    @proxy = Rexpl::GeneratorProxy.new
  end

  def test_swallows_everything_with_its_args
    @proxy.push 3
    @proxy.foo
    @proxy.bar
    @proxy.whatever
    @proxy.biwinning

    assert_equal 5, @proxy.instructions.size
    assert_equal [:push, 3], @proxy.instructions.first
  end

  def test_visit_executes_the_instructions
    @proxy.push 3
    @proxy.push_literal 'hey'

    g = Rubinius::Generator.new
    g.expects(:push).with(3)
    g.expects(:push_literal).with('hey')

    @proxy.visit(g) 
  end

  def test_reset
    @proxy.push 3
    @proxy.push 5

    Rexpl::Output.expects(:print_reset)

    @proxy.reset

    assert_equal 0, @proxy.instructions.size
  end

  def test_list
    @proxy.push 3
    @proxy.push 5

    Rexpl::Output.expects(:print_instruction).with([:push, 3], 0)
    Rexpl::Output.expects(:print_instruction).with([:push, 5], 1)

    @proxy.list
  end

  def test_draw
    @proxy.push 3
    @proxy.push 5
    @proxy.meta_send_op_plus 2

    Rexpl::Output.expects(:print_stack).with([3])
    Rexpl::Output.expects(:print_stack).with([3, 5])
    Rexpl::Output.expects(:print_stack).with([8])

    @proxy.draw
  end

  def teardown
    $stdout = STDOUT
  end
end
