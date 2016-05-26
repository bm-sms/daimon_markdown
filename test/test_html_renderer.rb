require "helper"

class HTMLRendererTest < Test::Unit::TestCase
  data(
    "header" => {
      input: %Q(# hi),
      expect: %Q(<h1>hi</h1>\n)
    }
  )
  def test_renderer(data)
    actual = process_markdown(data[:input])[:output].to_s

    assert_equal(actual, data[:expect])
  end
end
