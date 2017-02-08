module Erbc
  class Command
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def run
      template = read_erb
      result = compile(template)
      write(result)
    end

    private

    def read_erb
      File.read(request.erb)
    end

    def compile(template)
      Erbc::Compiler.new(request).compile(template)
    end

    def write(result)
      Erbc::Writer.new(request).write(result)
    end
  end
end
