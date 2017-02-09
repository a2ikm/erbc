require 'test_helper'

class ErbcCommandTest < ErbcTest
  def test_plain_command
    expected = read_sample("sample1.result")
    assert_output expected do
      new_command(erb: sample_path("sample1.erb")).run
    end
  end

  private

  def new_command(args = {})
    req = new_request(args)
    Erbc::Command.new(req)
  end
end
