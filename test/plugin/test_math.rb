require "helper"

class MathTest < Test::Unit::TestCase
  def test_inline_style
    doc = Nokogiri::HTML.fragment(<<~HTML)
    <p>{{math("$1+1=2$")}}</p>
    HTML
    node = doc.search(".//text()").first
    result = {}
    context = {}
    plugin = Daimon::Markdown::Plugin::Math.new(doc, node, result, context)
    plugin.call("$1+1=2$")
    expected_html = <<~HTML
    <p>$1+1=2$</p>
    HTML
    assert_equal(expected_html, doc.to_s)
  end

  def test_block_style
    doc = Nokogiri::HTML.fragment(<<~HTML)
    <p>{{math("$$
    1+1=2
    2+2=4
    \\dots
    n+n=2n
    $$")}}</p>
    HTML
    node = doc.search(".//text()").first
    result = {}
    context = {}
    plugin = Daimon::Markdown::Plugin::Math.new(doc, node, result, context)
    plugin.call(<<~EXPRESSION.chomp)
    $$
    1+1=2
    2+2=4
    \\dots
    n+n=2n
    $$
    EXPRESSION
    expected_html = <<~HTML.chomp
    <div class="math">$$
    1+1=2
    2+2=4
    \\dots
    n+n=2n
    $$</div>
    HTML
    assert_equal(expected_html, doc.to_s.chomp)
  end
end
