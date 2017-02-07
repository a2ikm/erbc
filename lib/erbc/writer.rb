module Erbc
  class Writer
    attr_reader :output

    def initialize(output = nil)
      @output = output
    end

    def write(result)
      with_output_io do |io|
        io.write(result)
      end
    end

    private

    def with_output_io
      if output
        File.open(output, "w") do |io|
          yield(io)
        end
      else
        yield(STDOUT)
      end
    end
  end
end
