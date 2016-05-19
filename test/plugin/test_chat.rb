require "helper"

class ChatTest < Test::Unit::TestCase
  def test_chat
    markdown = <<~TEXT
    # title

    {{chat("a.png", "chat1", "b.png", "chat2")}}
    TEXT
    expected_html = <<~HTML.chomp
    <div class="chat">
    <img src="a.png">
    <p>chat1</p>
    <img src="b.png">
    <p>chat2</p>
    </div>
    HTML
    result = process_markdown(markdown)
    actual_html = result[:output].search(".chat").first.to_s
    assert_equal(expected_html, actual_html)
  end

  def test_chat_multiple_lines
    markdown = <<~TEXT
    # title

    {{chat(
        "a.png",
        "chat1",
        "b.png",
        "chat2")
    }}
    TEXT
    expected_html = <<~HTML.chomp
    <div class="chat">
    <img src="a.png">
    <p>chat1</p>
    <img src="b.png">
    <p>chat2</p>
    </div>
    HTML
    result = process_markdown(markdown)
    actual_html = result[:output].search(".chat").first.to_s
    assert_equal(expected_html, actual_html)
  end
end
