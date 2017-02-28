require "helper"

class ErrorTest < Test::Unit::TestCase
  class DummyPlugin < DaimonMarkdown::Plugin::Base
    DaimonMarkdown::Plugin.register("dummy_error", self)

    def call
      raise DaimonMarkdown::Plugin::Error, "This is dummy error"
    end
  end

  class RuntimeErrorPlugin < DaimonMarkdown::Plugin::Base
    DaimonMarkdown::Plugin.register("runtime_error", self)

    def call
      raise "This is error"
    end
  end

  def test_parse_error
    result = process_markdown(%Q({{figure(\")}}))
    html = result[:output].to_s
    expected = %Q(<p>{{figure(\")}} (DaimonMarkdown::Parser::Error: unterminated string meets end of file)</p>\n)
    assert_equal(html, expected)
  end

  def test_unknown_plugin_error
    result = process_markdown(%Q({{nosuchplugin}}))
    html = result[:output].to_s
    expected = %Q(<p>Unknown plugin: nosuchplugin</p>\n)
    assert_equal(html, expected)
  end

  def test_plugin_error
    result = process_markdown("{{dummy_error}}")
    html = result[:output].to_s
    expected = <<~HTML
    <pre>Error occured in ErrorTest::DummyPlugin
    {{dummy_error}} (DaimonMarkdown::Plugin::Error: This is dummy error)
    HTML
    assert_equal(html.lines.take(2).join, expected)
  end

  def test_standard_error
    result = process_markdown("{{runtime_error}}")
    html = result[:output].to_s
    expected = <<~HTML
    <pre>Unexpected error occured in ErrorTest::RuntimeErrorPlugin
    {{runtime_error}} (RuntimeError: This is error)
    HTML
    assert_equal(html.lines.take(2).join, expected)
  end
end
