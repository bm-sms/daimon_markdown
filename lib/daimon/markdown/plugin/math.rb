module Daimon
  module Markdown
    class Plugin
      class Math < Base
        Plugin.register("math", self)

        def call(expression)
          if expression.start_with?("$$")
            node.parent.replace(%Q(<div class="math">#{expression}</div>))
          else
            node.replace(expression)
          end
        end
      end
    end
  end
end
