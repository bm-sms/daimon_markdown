require "helper"
require "daimon/markdown/plugin"

class PluginTest < Test::Unit::TestCase
  def test_unknown_plugin
    assert_raise(Daimon::Markdown::Plugin::UnknownPluginError, "Unknown plugin: unknown") do
      Daimon::Markdown::Plugin.lookup("unknown")
    end
  end
end
