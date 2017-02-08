require "erb"
require "yaml"

module Erbc
  class Compiler
    attr_reader :template, :env

    def initialize(template, config: nil, vars: {})
      @template = template
      @env      = build_env(config: config, vars: vars)
    end

    def compile
      ERB.new(template, nil, "-").result(env.b)
    end

    class Env
      def b
        binding
      end
    end

    private

    def build_env(config: nil, vars: {})
      params = {}
      params.merge!(load_config(config))
      params.merge!(vars)

      env = Env.new
      params.each do |key, value|
        env.define_singleton_method(key) { value }
      end

      env
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
