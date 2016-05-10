require "daimon/markdown/parser"

module Daimon
  module Markdown
    module Filter
      class Plugin < HTML::Pipeline::Filter
        def call
          doc.search(".//text()").each do |node|
            node.scan(/{{(.+?)}}/) do |str|
              parser = Daimon::Markdown::Parser.new(str)
              parser.parse
              plugin_class = Daimon::Markdown::Plugin.lookup(parser.name)
              plugin = plugin_class.new
              # TODO: Remove <p></p>
              node.replace(plugin.call(*parser.args))
            end
          end
        end
      end
    end
  end
end
