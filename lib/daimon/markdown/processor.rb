require "daimon/markdown/filter"
require "daimon/markdown/plugin"

module Daimon
  module Markdown
    class Processor

      DEFAULT_FILTERS = [
        Daimon::Markdown::Filter::Plugin
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
end
