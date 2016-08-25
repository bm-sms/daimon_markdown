require "test-unit"
require "test/unit/notify"

require "daimon/markdown"

def process_markdown(markdown, context = {})
  processor = Daimon::Markdown::Processor.new
  processor.call(markdown, context)
end
