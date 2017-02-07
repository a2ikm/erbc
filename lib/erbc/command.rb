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
      Erbc::Compiler.new(template,
                         config: options[:config],
                         vars: options[:vars]).compile
    end

    def write(result)
      Erbc::Writer.new(options[:output]).write(result)
    end

    def default_options
      {
        config: nil,
        output: nil,
        vars:   [],
      }
    end

    def parse_options(argv)
      options = default_options

      OptionParser.new do |op|
        op.on("-c", "--config=FILE") do |v|
          options[:config] = v
        end
        op.on("-o", "--output=FILE") do |v|
          options[:output] = v
        end
        op.on("-v", "--var=NAME:VALUE") do |v|
          options[:vars] << v
        end
      end.parse!(argv)

      erb = argv.shift
      [erb, options]
    end
  end
end
