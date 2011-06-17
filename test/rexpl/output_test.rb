require 'test_helper'
require 'stringio'

class OutputTest < MiniTest::Unit::TestCase
  def setup
    $stdout = StringIO.new
  end

  def test_print_banner
    Rexpl::Output.print_banner
    assert_match /rexpl/, $stdout.string
  end
  
  def test_print_prompt
    Rexpl::Output.print_prompt
    assert_match />/, $stdout.string
  end

  def test_print_reset
    Rexpl::Output.print_reset
    assert_match /Reseted!/, $stdout.string
  end

  def test_print_debug_info
    Rexpl::Output.print_debug_info("3", '"some_value"')
    assert_match /Stack size: 3/, $stdout.string
    assert_match /Topmost value: "some_value"/, $stdout.string
  end

  def test_print_instruction
    instruction = ['send', ':puts', '1', 'true']

    Rexpl::Output.print_instruction(instruction, 3)
    assert_match /send/, $stdout.string
    assert_match /:puts/, $stdout.string
    assert_match /1/, $stdout.string
    assert_match /true/, $stdout.string
    assert_match /3/, $stdout.string
  end

  def test_print_stack
    cells = %w(Rubinius 23)
    Rexpl::Output.print_stack(cells)
    assert_match /Current stack/, $stdout.string
    assert_match /23/, $stdout.string
    assert_match /Rubinius/, $stdout.string

    # Rubinius should appear after 23, since cells are reversed
    refute_match /Rubinius/, $stdout.string.split('23').first
    assert_match /Rubinius/, $stdout.string.split('23').last
  end

  def test_print_rationale
    Rexpl::Output.print_rationale
    assert_match /list/, $stdout.string
    assert_match /reset/, $stdout.string
    assert_match /draw/, $stdout.string
  end

  def teardown
    $stdout = STDOUT
  end
end
