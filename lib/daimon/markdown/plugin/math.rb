module Daimon
  module Markdown
    class Plugin
      class Math < Base
        Plugin.register("math", self)

        def self.script_tag
          <<~TAG
          <script type="text/javascript"
                  async
                  src="https://cdn.mathjax.org/mathjax/2.6-latest/MathJax.js?config=TeX-MML-AM_CHTML">
          </script>
          <script type="text/x-mathjax-config">
            MathJax.Hub.Config({
              tex2jax: {inlineMath: [['$','$']]},
              asciimath2jax: {delimiters: [['`', '`']]},
              TeX: {extensions: ["mhchem.js"]}
            });
          </script>
          TAG
        end

        def call(expression)
          if expression.start_with?("$$")
            node.parent.replace(%Q(<div class="math">#{expression}</div>))
          else
            result[:plugins] << expression
          end
        end
      end
    end
  end
end
