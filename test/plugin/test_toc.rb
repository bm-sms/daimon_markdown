require "helper"
require "cgi/util"

class TocTest < Test::Unit::TestCase
  include CGI::Util

  def test_simple
    markdown = <<~TEXT

    {{toc}}
    
    # title

    This is a text
    TEXT

    expected_toc_html = <<~HTML.chomp
    <ul class="section-nav">
    <li><a href="#title">title</a></li>
    </ul>
    HTML
    expected_header_ids = ["title"]
    assert_toc(expected_toc_html, expected_header_ids, markdown)
  end

  def test_nested
    markdown = <<~TEXT

    {{toc}}
    
    # title

    This is a text

    ## title 2
    
    This is a text

    ## title 2

    This is a text

    # title 1

    This is a text
    TEXT
    
    expected_toc_html = <<~HTML.chomp
    <ul class="section-nav">
    <li><a href="#title">title</a></li>
    <ul>
    <li><a href="#title-2">title 2</a></li>
    <li><a href="#title-2-1">title 2</a></li>
    </ul>
    <li><a href="#title-1">title 1</a></li>
    </ul>
    HTML
    expected_header_ids = ["title", "title-2", "title-2-1", "title-1"]
    assert_toc(expected_toc_html, expected_header_ids, markdown)
  end

  def test_skip
    markdown = <<~TEXT

    {{toc}}
    
    # title

    This is a text

    ### title 3
    
    This is a text

    # title 1

    This is a text
    TEXT
    
    expected_toc_html = <<~HTML.chomp
    <ul class="section-nav">
    <li><a href="#title">title</a></li>
    <ul>
    <ul>
    <li><a href="#title-3">title 3</a></li>
    </ul>
    </ul>
    <li><a href="#title-1">title 1</a></li>
    </ul>
    HTML
    expected_header_ids = ["title", "title-3", "title-1"]
    assert_toc(expected_toc_html, expected_header_ids, markdown)
  end

  def test_simple_japanese
    markdown = <<~TEXT

    {{toc}}
    
    # 日本語

    This is a text
    TEXT

    expected_toc_html = <<~HTML.chomp
    <ul class="section-nav">
    <li><a href="##{escape("日本語")}">日本語</a></li>
    </ul>
    HTML
    expected_header_ids = ["日本語"]
    assert_toc(expected_toc_html, expected_header_ids, markdown)
  end

  private

  def assert_toc(expected_toc_html, expected_header_ids, markdown)
    processor = Daimon::Markdown::Processor.new
    result = processor.call(markdown)
    actual_toc_html = result[:output].search("ul").first.to_s
    actual_header_ids = result[:output].search("h1, h2, h3, h4, h5, h6").map do |node|
      node["id"]
    end
    assert_equal(expected_toc_html, actual_toc_html)
    assert_equal(expected_header_ids, actual_header_ids)
  end
end