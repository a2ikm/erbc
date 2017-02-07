require 'test_helper'

class ErbcCommandTest < Minitest::Test
  def test_parse_options_with_no_args
    command = new_command([])
    assert_nil command.erb
    assert_nil command.options[:config]
    assert_nil command.options[:output]
    assert_equal [], command.options[:vars]
  end

  private

  def new_command(argv)
    Erbc::Command.new(argv)
  end
end
