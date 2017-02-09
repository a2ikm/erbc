$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'erbc'

require 'minitest/autorun'

class ErbcTest < Minitest::Test
  private

  def new_request(args = {})
    Erbc::Request.new(args)
  end

  def sample_path(name)
    File.expand_path("../../test/samples/#{name}", __FILE__)
  end

  def read_sample(name)
    File.read(sample_path(name))
  end
end
