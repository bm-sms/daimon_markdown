class ErrorTest < Test::Unit::TestCase
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
end
