require "helper"
require "daimon_markdown/plugin"

class PluginTest < Test::Unit::TestCase
  def test_unknown_plugin
    assert_raise(DaimonMarkdown::Plugin::UnknownPluginError, "Unknown plugin: unknown") do
      DaimonMarkdown::Plugin.lookup("unknown")
    end
  end
end
