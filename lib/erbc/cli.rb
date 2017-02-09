module Erbc
  class CLI
    attr_reader :request

    def initialize(argv)
      @request = parse_arguments(argv)
    end

    def run
      Command.new(request).run
    end

    private

    def parse_arguments(argv)
      args = {}

      OptionParser.new do |op|
        op.on("-c", "--config=FILE") do |v|
          args[:config] = v
        end
        op.on("-o", "--output=FILE") do |v|
          args[:output] = v
        end
        op.on("-T", "--trim-mode=MODE") do |v|
          args[:trim_mode] = v
        end
        op.on("-v", "--var=NAME:VALUE") do |v|
          name, value = v.split(":", 2)
          (args[:vars] ||= {})[name] = value
        end
      end.parse!(argv)

      args[:erb] = argv.shift
      Request.new(args)
    end
  end
end
