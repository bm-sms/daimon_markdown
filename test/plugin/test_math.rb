require "helper"

class MathTest < Test::Unit::TestCase
  def test_inline_style
    markdown = <<~TEXT
    This is math expression: {{math("$1+1=2$")}}
    TEXT
    expected = <<~HTML
    <p>This is math expression: $1+1=2$</p>
    HTML
    result = process_markdown(markdown)
    actual = result[:output].to_s
    assert_equal(expected, actual)
  end

  def test_multiple_plugin_syntax_in_one_line
    markdown = <<~TEXT
    This is math expression: {{math("$1+1=2$")}} or {{math("$2+2=4$")}}
    TEXT
    expected = <<~HTML
    <p>This is math expression: $1+1=2$ or $2+2=4$</p>
    HTML
    result = process_markdown(markdown)
    actual = result[:output].to_s
    assert_equal(expected, actual)
  end

  def test_block_style
    markdown = <<~TEXT
    {{math("$$
    1+1=2
    2+2=4
    \\dots
    n+n=2n
    $$")}}
    TEXT
    expected = <<~HTML
    <div class="math">$$
    1+1=2
    2+2=4
    \\dots
    n+n=2n
    $$</div>
    HTML
    result = process_markdown(markdown)
    actual = result[:output].to_s
    assert_equal(expected, actual)
  end
end
