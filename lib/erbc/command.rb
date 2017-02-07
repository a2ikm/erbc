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
      puts compile(template)
    end

    private

    def compile(template)
      Erbc::Compiler.new(template).compile
    end
  end
end
