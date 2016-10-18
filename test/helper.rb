require "test-unit"
require "test/unit/notify"

require "daimon_markdown"

def process_markdown(markdown, context = {})
  processor = DaimonMarkdown::Processor.new
  processor.call(markdown, context)
end
