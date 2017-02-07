require 'test_helper'

class ErbcTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Erbc::VERSION
  end
end
