module DaimonMarkdown
  class Plugin

    PLUGIN_REGISTRY = {}

    class UnknownPluginError < StandardError
    end

    class << self
      def lookup(name)
        PLUGIN_REGISTRY.fetch(name)
      rescue KeyError
        raise UnknownPluginError, "Unknown plugin: #{name}"
      end

      def register(name, klass)
        PLUGIN_REGISTRY[name] = klass
      end
    end
  end
end

require "daimon_markdown/plugin/base"
Dir.glob("#{__dir__}/plugin/*.rb") do |entry|
  require entry
end
