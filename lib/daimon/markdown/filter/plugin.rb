require "daimon/markdown/parser"

module Daimon
  module Markdown
    module Filter
      class Plugin < ::HTML::Pipeline::Filter
        def call
          doc.search(".//text()").each do |node|
            next if node.parent.name == "code" # skip code block
            result[:plugins] = []
            node.to_s.scan(/{{(.+?)}}/m) do |str|
              parser = Daimon::Markdown::Parser.new(str[0])
              parser.parse
              plugin_class = Daimon::Markdown::Plugin.lookup(parser.name)
              plugin = plugin_class.new(doc, node, result, context)
              plugin.call(*parser.args)
            end
            unless result[:plugins].empty?
              scanner = StringScanner.new(node.to_s)
              new_node = ""
              loop do
                if scanner.match?(/{{.+?}}/)
                  new_node << result[:plugins].shift
                  scanner.pos += scanner.matched_size
                else
                  new_node << scanner.getch
                end
                break if scanner.eos?
              end
              node.replace(new_node)
            end
          end
          doc
        end
      end
    end
  end
end
