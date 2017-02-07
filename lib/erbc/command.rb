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
      result = ERB.new(template).result
      puts result
    end
  end
end
