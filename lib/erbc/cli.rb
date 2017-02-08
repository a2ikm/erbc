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
      req = Request.new

      OptionParser.new do |op|
        op.on("-c", "--config=FILE") do |v|
          req.config = v
        end
        op.on("-o", "--output=FILE") do |v|
          req.output = v
        end
        op.on("-v", "--var=NAME:VALUE") do |v|
          name, value = v.split(":", 2)
          req.vars[name] = value
        end
      end.parse!(argv)

      req.erb = argv.shift
      req
    end
  end
end
