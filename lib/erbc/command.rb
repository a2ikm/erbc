require "erb"

module Erbc
  class Command
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def run
      path = argv[0]
      template = File.read(path)
      result = Erbc::Compiler.new(template).compile
      puts result
    end
  end
end
