require "erb"

module Erbc
  class Command
    attr_reader :erb, :options

    def initialize(argv)
      @erb, @options = parse_options(argv)
    end

    def run
      template = File.read(erb)
      result = compile(template)
      write(result)
    end

    private

    def compile(template)
      Erbc::Compiler.new(template).compile
    end

    def write(result)
      Erbc::Writer.new(options[:output]).write(result)
    end

    def parse_options(argv)
      options = {}

      OptionParser.new do |op|
        op.on("-o", "--output=FILE") do |v|
          options[:output] = v
        end
      end.parse!(argv)

      erb = argv.shift
      [erb, options]
    end
  end
end
