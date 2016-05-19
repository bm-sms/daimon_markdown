require "test-unit"
require "test/unit/notify"

require "daimon/markdown"

def process_markdown(markdown)
  processor = Daimon::Markdown::Processor.new
  processor.call(markdown)
end
