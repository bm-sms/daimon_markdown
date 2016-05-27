module Daimon
  module Markdown
    class Plugin

      PLUGIN_REGISTRY = {}

      class UnknownPluginError < StandardError
        def initialize(name)
          @name
        end

        def message
          "Unknown plugin: #{@name}"
        end
      end

      class << self
        def lookup(name)
          PLUGIN_REGISTRY.fetch(name)
        rescue KeyError
          raise UnknownPluginError, name
        end

        def register(name, klass)
          PLUGIN_REGISTRY[name] = klass
        end
      end
    end
  end
end

require "daimon/markdown/plugin/base"
Dir.glob("#{__dir__}/plugin/*.rb") do |entry|
  require entry
end
