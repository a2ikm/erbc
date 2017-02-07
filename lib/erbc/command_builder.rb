module Erbc
  class CommandBuilder
    attr_reader :erb, :options

    def initialize(argv)
      @erb, @options = parse_options(argv)
    end

    def build
      Command.new(
        erb:    erb,
        config: options[:config],
        output: options[:output],
        vars:   options[:vars],
      )
    end

    private

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
