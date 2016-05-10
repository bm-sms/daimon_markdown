module Daimon
  module Markdown
    class Plugin
      class Base
        def call(*args)
          raise "Implement this method in subclass"
        end
      end
    end
  end
end
