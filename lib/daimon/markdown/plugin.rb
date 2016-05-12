module Daimon
  module Markdown
    class Plugin

      PLUGIN_REGISTRY = {}

      class << self
        def lookup(name)
          PLUGIN_REGISTRY.fetch(name)
        end

        def register(name, klass)
          PLUGIN_REGISTRY[name] = klass
        end
      end
    end
  end
end

require "daimon/markdown/plugin/base"
require "daimon/markdown/plugin/figure"
require "daimon/markdown/plugin/toc"
