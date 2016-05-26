require "rouge"
require "rouge/plugins/redcarpet"

module Daimon
  module Markdown
    module Redcarpet
      class HTMLRenderer < ::Redcarpet::Render::HTML
        include Rouge::Plugins::Redcarpet

        def initialize(extensions = {})
          super
          @plugins = []
        end

        def preprocess(full_document)
          scanner = StringScanner.new(full_document)
          loop do
            break if scanner.eos?
            if scanner.match?(/^```.*$/)
              scanner.pos += scanner.matched_size
              scanner.scan_until(/^```.*$/)
            end
            if scanner.match?(/^ {4}.*$/)
              scanner.pos += scanner.matched_size
            end
            if scanner.match?(/{{.+?}}/m)
              @plugins << scanner.matched
              scanner.pos += scanner.matched_size
            else
              scanner.getch
            end
          end
          full_document
        end

        def postprocess(full_document)
          return full_document if @plugins.empty?
          document = ""
          scanner = StringScanner.new(full_document)
          loop do
            break if scanner.eos?
            if scanner.match?(%r{<pre class=".+"><code>.+</code></pre>}m)
              document << scanner.matched
              scanner.pos += scanner.matched_size
            end
            if scanner.match?(/{{.+?}}/m)
              document << @plugins.shift
              scanner.pos += scanner.matched_size
            else
              document << scanner.getch
            end
          end
          document
        end
      end
    end
  end
end
