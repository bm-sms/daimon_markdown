module Daimon
  module Markdown
    class Plugin
      class TableOfContents
        Plugin.register("toc", self)

        def call(level = 0)
          # TODO: implement this method
          "<p>Table of Contents!!!</p>"
        end
      end
    end
  end
end
