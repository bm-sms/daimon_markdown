require "nokogiri"
require "redcarpet"

require "daimon_markdown/redcarpet/html_renderer"

module DaimonMarkdown
  module Filter
    class Redcarpet < HTML::Pipeline::TextFilter
      def call
        Nokogiri::HTML.fragment(markdown.render(@text))
      end

      private

      def markdown
        @markdown ||= ::Redcarpet::Markdown.new(
          DaimonMarkdown::Redcarpet::HTMLRenderer.new(hard_wrap: true),
          fenced_code_blocks: true,
          tables: true)
      end
    end
  end
end
