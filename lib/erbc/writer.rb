module Erbc
  class Writer
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def write(result)
      with_output_io do |io|
        io.write(result)
      end
    end

    private

    def with_output_io
      if output = request.output
        File.open(output, "w") do |io|
          yield(io)
        end
      else
        yield($stdout)
      end
    end
  end
end
