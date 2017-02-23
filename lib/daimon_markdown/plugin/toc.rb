module DaimonMarkdown
  class Plugin
    class TableOfContents < Base
      Plugin.register("toc", self)

      def call(limit = nil)
        toc_html = ""
        toc_class = context[:toc_class] || "section-nav"

        ul_list = Hash.new {|h, k| h[k] = UnorderedList.new }
        ul_list[1] = UnorderedList.new(html_class: toc_class)
        doc.css("h1, h2, h3, h4, h5, h6").each do |header_node|
          header = Header.new(header_node)
          next if limit && limit < header.level
          next unless header.content?
          header.unique_id = generate_unique_id(header.text)
          unless ul_list.key?(header.level)
            header.level.downto(2) do |n|
              if ul_list[n - 1].items.empty?
                li = ListItem.new
                li << ul_list[n]
                ul_list[n - 1] << li
              else
                ul_list[n - 1] << ul_list[n] unless ul_list[n - 1].items.include?(ul_list[n])
              end
            end
          end
          ul_list[header.level] << ListItem.new(header: header)
        end

        unless ul_list[1].items.empty?
          toc_header = context[:toc_header] || ""
          toc_html = "#{toc_header}#{ul_list[1].to_html}"
        end
        node.parent.replace(toc_html)
      end

      private

      def generate_unique_id(text)
        @headers ||= Hash.new(0)
        id = text.downcase
        id.tr!(" ", "-")
        id.gsub!(/\s/, "")

        unique_id =
          if @headers[id] > 0
            "#{id}-#{@headers[id]}"
          else
            id
          end
        @headers[id] += 1
        unique_id
      end

      class Header
        attr_reader :level, :text, :unique_id

        def initialize(node)
          @node = node
          @level = node.name.tr("h", "").to_i
          @text = node.text
          @unique_id = ""
        end

        def unique_id=(id)
          @node["id"] = id
          @unique_id = id
        end

        def content?
          @node.children.first
        end

        def link
          %Q(<a href="##{unique_id}">#{text}</a>)
        end
      end

      class UnorderedList
        attr_reader :items, :level

        def initialize(html_class: nil, level: 1)
          @html_class = html_class
          @level = level
          @items = []
        end

        def <<(item)
          @items << item
        end

        def to_html
          if @html_class
            %Q(<ul class="#{@html_class}">\n#{@items.map(&:to_html).join("\n")}\n</ul>)
          else
            %Q(<ul>\n#{@items.map(&:to_html).join("\n")}\n</ul>)
          end
        end
      end

      class ListItem
        attr_reader :items

        def initialize(header: nil)
          @header = header
          @items = []
        end

        def <<(item)
          @items << item
        end

        def to_html
          if @items.empty?
            %Q(<li>#{@header.link}</li>)
          else
            %Q(<li>#{@items.map(&:to_html).join("\n")}\n</li>)
          end
        end
      end
    end
  end
end
