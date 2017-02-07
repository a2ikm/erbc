require "erb"
require "yaml"

module Erbc
  class Compiler
    attr_reader :template, :binding

    def initialize(template, config: nil)
      @template = template
      @binding  = build_binding(config: config)
    end

    def compile
      ERB.new(template).result(binding)
    end

    class Env
      def b
        binding
      end
    end

    private

    def build_binding(config: nil)
      params = {}
      params.merge!(load_config(config))

      env = Env.new
      params.each do |key, value|
        env.define_singleton_method(key) { value }
      end

      env.b
    end

    def load_config(config = nil)
      if config
        YAML.load_file(config)
      else
        {}
      end
    end
  end
end
