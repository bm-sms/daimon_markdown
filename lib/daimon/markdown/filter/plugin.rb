require "daimon/markdown/parser"

module Daimon
  module Markdown
    module Filter
      class Plugin < ::HTML::Pipeline::Filter
        def call
          doc.search(".//text()").each do |node|
            node.to_s.scan(/{{(.+?)}}/) do |str|
              parser = Daimon::Markdown::Parser.new(str[0])
              parser.parse
              plugin_class = Daimon::Markdown::Plugin.lookup(parser.name)
              plugin = plugin_class.new(doc, node, result, context)
              plugin.call(*parser.args)
            end
          end
          doc
        end
      end
    end
  end
end
