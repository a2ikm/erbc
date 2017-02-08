module Erbc
  class Request
    attr_accessor :erb, :config, :output, :trim_mode, :vars

    def initialize
      @erb        = nil
      @config     = nil
      @output     = nil
      @trim_mode  = "-".freeze
      @vars       = {}
    end
  end
end
