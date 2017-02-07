module Erbc
  class Compiler
    attr_reader :template

    def initialize(template)
      @template = template
    end

    def compile
      ERB.new(template).result
    end
  end
end
