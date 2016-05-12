module Daimon
  module Markdown
    class Plugin
      class Figure < Base
        Plugin.register("figure", self)

        def call(src, alt, caption)
          figure = <<~HTML
          <figure>
            <img src="#{src}" alt="#{alt}">
            <figcaption>#{caption}</figcaption>
          </figure>
          HTML
          node.parent.replace(figure)
        end
      end
    end
  end
end
