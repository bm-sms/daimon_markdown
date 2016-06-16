require "helper"

class CodeBlockTest < Test::Unit::TestCase
  def test_fenced_code_block
    markdown = <<~TEXT
    # hi

    ```text
    {{math("$1+1=2$")}}
    ```

    {{math("$1+1=2$")}}
    TEXT
    result = process_markdown(markdown)
    expected = <<~HTML
    <h1>hi</h1>
    <pre class="highlight plaintext"><code>{{math("$1+1=2$")}}
    </code></pre>
    <p>$1+1=2$</p>
    HTML
    assert_equal(expected, result[:output].to_s)
  end

  def test_indented_code_block
    markdown = <<~TEXT
    # hi

        This is math expression.
        {{math("$1+1=2$")}}

    {{math("$1+1=2$")}}
    TEXT
    result = process_markdown(markdown)
    expected = <<~HTML
    <h1>hi</h1>
    <pre class="highlight plaintext"><code>This is math expression.\n{{math("$1+1=2$")}}
    </code></pre>
    <p>$1+1=2$</p>
    HTML
    assert_equal(expected, result[:output].to_s)
  end

  def test_indented_code_block_with_unmatched_plugins
    markdown = <<~TEXT
    # hi

        This is math expression.
        {{math("$1+1=2$")}}

    {{math("$1+1=2$")}}

    {{math("$2+2=4$")}}
    TEXT
    result = process_markdown(markdown)
    expected = <<~HTML
    <h1>hi</h1>
    <pre class="highlight plaintext"><code>This is math expression.\n{{math("$1+1=2$")}}
    </code></pre>
    <p>$1+1=2$</p>

    <p>$2+2=4$</p>
    HTML
    assert_equal(expected, result[:output].to_s)
  end

  def test_inline_code
    markdown = <<~TEXT
    # hi

    `{{math("$1+1=2$")}}`

    {{math("$1+1=2$")}}
    TEXT
    result = process_markdown(markdown)
    expected = <<~HTML
    <h1>hi</h1>

    <p><code>{{math("$1+1=2$")}}</code></p>

    <p>$1+1=2$</p>
    HTML
    assert_equal(expected, result[:output].to_s)
  end

  def test_html_comment
    markdown = <<~TEXT
    # hi

    <!-- {{math("$1+1=2$")}} -->

    {{math("$1+1=2$")}}
    TEXT
    result = process_markdown(markdown)
    expected = <<~HTML
    <h1>hi</h1>

    <!-- {{math("$1+1=2$")}} -->

    <p>$1+1=2$</p>
    HTML
    assert_equal(expected, result[:output].to_s)
  end
end
