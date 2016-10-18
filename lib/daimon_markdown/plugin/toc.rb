module DaimonMarkdown
  class Plugin
    class TableOfContents < Base
      Plugin.register("toc", self)

      def call(limit = nil)
        toc_html = ""
        items = []

        headers = Hash.new(0)
        previous_level = 1
        doc.css("h1, h2, h3, h4, h5, h6").each do |header_node|
          level = header_node.name.tr("h", "").to_i
          next if limit && limit < level
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
            diff = level - previous_level
            case
            when diff > 0
              items.concat(["<ul>"] * diff)
            when diff < 0
              items.concat(["</ul>"] * diff.abs)
            end
            items << list_item(link_to(unique_id, text))
            header_node["id"] = unique_id
          end
          previous_level = level
        end
        toc_class = context[:toc_class] || "section-nav"
        toc_header = context[:toc_header] || ""
        unless items.empty?
          toc_html = %Q(#{toc_header}<ul class="#{toc_class}">\n#{items.join("\n")}\n</ul>)
        end
        node.parent.replace(toc_html)
      end

      private

      def link_to(href, text)
        %Q(<a href="##{href}">#{text}</a>)
      end

      def list_item(content)
        %Q(<li>#{content}</li>)
      end
    end
  end
end
