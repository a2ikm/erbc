module Erbc
  class Request
    attr_accessor :erb, :config, :output, :vars

    def initialize
      @erb    = nil
      @config = nil
      @output = nil
      @vars   = {}
    end
  end
end
