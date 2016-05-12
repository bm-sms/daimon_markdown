require "helper"

class FigureTest < Test::Unit::TestCase
  def test_figure
    doc = Nokogiri::HTML.fragment(<<~HTML)
    <p>{{figure "a.png", "alt text", "caption text"}}</p>
    HTML
    node = doc.search(".//text()").first
    result = {}
    context = {}
    plugin = Daimon::Markdown::Plugin::Figure.new(doc, node, result, context)
    plugin.call("a.png", "alt text", "caption text")
    expected_html = <<~HTML
    <figure>
      <img src="a.png" alt="alt text">
      <figcaption>caption text</figcaption>
    </figure>
    HTML
    assert_equal(expected_html, doc.to_s.chomp)
  end
end
