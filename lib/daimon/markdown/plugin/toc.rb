module Daimon
  module Markdown
    class Plugin
      class TableOfContents < Base
        Plugin.register("toc", self)

        def call
          toc_html = []

          headers = Hash.new(0)
          doc.css("h1, h2, h3, h4, h5, h6").each do |header_node|
            text = header_node.text
            id = text.downcase
            id.gsub!(/ /, "-")
            id.gsub!(/\s/, "")

            if headers[id] > 0
              unique_id = "#{id}-#{headers[id]}"
            else
              unique_id = id
            end
            headers[id] += 1
            header_content = header_node.children.first
            # TODO: Arrange indent level
            if header_content
              toc_html << %Q(<li><a href="##{unique_id}">#{text}</a></li>)
              header_node["id"] = unique_id
            end
          end
          toc_class = context[:toc_class] || "section-nav"
          unless toc_html.empty?
            toc_html = %Q(<ul class="#{toc_class}">\n#{toc_html.join("\n")}\n</ul>)
          end
          node.parent.replace(toc_html)
        end
      end
    end
  end
end
