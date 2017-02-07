require "erb"
require "yaml"

module Erbc
  class Compiler
    attr_reader :template, :binding

    def initialize(template, config: nil, vars: [])
      @template = template
      @binding  = build_binding(config: config, vars: vars)
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

    def build_binding(config: nil, vars: [])
      params = {}
      params.merge!(load_config(config))
      params.merge!(load_vars(vars))

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

    def load_vars(vars = [])
      vars.inject({}) do |hash, nv|
        name, value = nv.split(":", 2)
        hash[name] = value
        hash
      end
    end
  end
end
