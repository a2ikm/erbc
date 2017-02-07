module Erbc
  class Command
    attr_reader :erb, :config, :output, :vars

    def initialize(erb:, config: nil, output: nil, vars: [])
      @erb    = erb
      @config = config
      @output = output
      @vars   = vars
    end

    def run
      template = read_erb
      result = compile(template)
      write(result)
    end

    private

    def read_erb
      File.read(erb)
    end

    def compile(template)
      Erbc::Compiler.new(template,
                         config: config,
                         vars: vars).compile
    end

    def write(result)
      Erbc::Writer.new(output).write(result)
    end
  end
end
