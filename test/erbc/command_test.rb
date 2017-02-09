require 'test_helper'

class ErbcCommandTest < ErbcTest
  def test_plain_command
    expected = read_sample("sample1.result")
    assert_output expected do
      new_command(erb: sample_path("sample1.erb")).run
    end
  end

  def test_embedding_config_command
    expected = read_sample("sample2.result")
    assert_output expected do
      new_command(erb: sample_path("sample2.erb"),
                  config: sample_path("sample2.config.yml")).run
    end
  end

  def test_embedding_vars_command
    expected = read_sample("sample3.result")
    assert_output expected do
      new_command(erb: sample_path("sample3.erb"),
                  vars: { var1: "value1" }).run
    end
  end

  def test_specifying_output_path_command
    expected = read_sample("sample1.result")
    actual = capture_output("sample1.actual") do |output|
      new_command(erb: sample_path("sample1.erb"),
                  output: output).run
    end
    assert_equal expected, actual
  end

  private

  def new_command(args = {})
    req = new_request(args)
    Erbc::Command.new(req)
  end
end
