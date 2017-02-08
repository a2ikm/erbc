require "erb"
require "yaml"

module Erbc
  class Compiler
    attr_reader :request, :context

    def initialize(request)
      @request = request
      @context = build_context(request)
    end

    def compile(template)
      ERB.new(template, nil, request.trim_mode).result(context.b)
    end

    class Context
      def b
        binding
      end
    end

    private

    def build_context(request)
      params = {}
      params.merge!(load_config(request.config))
      params.merge!(request.vars)

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
