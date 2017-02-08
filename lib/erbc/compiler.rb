require "erb"
require "yaml"

module Erbc
  class Compiler
    attr_reader :template, :context

    def initialize(template, config: nil, vars: {})
      @template = template
      @context  = build_context(config: config, vars: vars)
    end

    def compile
      ERB.new(template, nil, "-").result(context.b)
    end

    class Context
      def b
        binding
      end
    end

    private

    def build_context(config: nil, vars: {})
      params = {}
      params.merge!(load_config(config))
      params.merge!(vars)

      context = Context.new
      params.each do |key, value|
        context.define_singleton_method(key) { value }
      end

      context
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
