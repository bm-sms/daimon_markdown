require "html/pipeline"

require "daimon_markdown/filter"
require "daimon_markdown/plugin"

module DaimonMarkdown
  class Processor

    DEFAULT_FILTERS = [
      DaimonMarkdown::Filter::Redcarpet,
      DaimonMarkdown::Filter::Plugin
    ]

    attr_reader :context

    def initialize(context = {})
      @context = context
    end

    def call(input, context = {})
      HTML::Pipeline.new(filters, @context).call(input, context)
    end

    def filters
      @filters ||= DEFAULT_FILTERS.clone
    end
  end
end
