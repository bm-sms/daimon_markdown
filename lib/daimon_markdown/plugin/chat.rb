module DaimonMarkdown
  class Plugin
    class Chat < Base
      Plugin.register("chat", self)

      def call(*args)
        speaches = []
        args.each_slice(2) do |url, text|
          speaches << <<~SPEACH.chomp
          <img src="#{url}" />
          <p>#{text}</p>
          SPEACH
        end
        html = %Q(<div class="chat">\n#{speaches.join("\n")}\n</div>)
        node.parent.replace(html)
      end
    end
  end
end
