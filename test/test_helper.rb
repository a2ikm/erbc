$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'erbc'

require 'minitest/autorun'

class ErbcTest < Minitest::Test
  private

  def new_request(args = {})
    Erbc::Request.new(args)
  end

  def root_path
    File.expand_path("../..", __FILE__)
  end

  def sample_path(name)
    File.join(root_path, "test", "samples", name)
  end

  def read_sample(name)
    File.read(sample_path(name))
  end

  def out_path(name)
    File.join(root_path, "tmp", name)
  end
end
