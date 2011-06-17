require 'test_helper'

class EnvironmentTest < MiniTest::Unit::TestCase

  def test_run
    Rexpl::Output.stubs(:print_banner)
    Rexpl::Output.stubs(:print_prompt)

    Rexpl::Environment.expects(:gets).times(3).returns('noop', 'push 3', nil)

    proxy = mock
    Rexpl::Environment.class_variable_set(:@@generator, proxy)

    proxy.expects(:instance_eval).with('noop')
    proxy.expects(:instance_eval).with('push 3')
    proxy.expects(:visit).with do |g|
      assert_kind_of Rubinius::Generator, g
    end.twice

    Rexpl::Environment.run
  end

end
