module Erbc
  class Request
    attr_reader :env

    def initialize(args = {})
      @env = default.merge(symbolize_keys(args))
    end

    DEFAULT = {
      erb:        nil,
      config:     nil,
      output:     nil,
      trim_mode:  "-".freeze,
      vars:       {},
    }.freeze

    def default
      DEFAULT
    end

    DEFAULT.each_keys do |key|
      class_eval <<-RUBY, __FILE__, __LINE__+1
        def #{key}
          env[:#{key}]
        end
        def #{key}=(val)
          env[:#{key}] = val
        end
      RUBY
    end

    private

    def symbolize_keys(hash)
      hash.inject({}) do |ret, (key, val)|
        ret[key.to_sym] = val
        ret
      end
    end
  end
end
