require "nokogiri"
require "redcarpet"

require "daimon/markdown/redcarpet/html_renderer"

module Daimon
  module Markdown
    module Filter
      class Redcarpet < HTML::Pipeline::TextFilter
        def call
          Nokogiri::HTML.fragment(markdown.render(@text))
        end

        private

        def markdown
          renderer = Daimon::Markdown::Redcarpet::HTMLRenderer.new(hard_wrap: true)
          @markdown ||= ::Redcarpet::Markdown.new(
            renderer,
            fenced_code_blocks: true,
            tables: true)
        end
      end
    end
  end
end
