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
          @math_notations = []
        end

        def preprocess(full_document)
          scanner = StringScanner.new(full_document)
          loop do
            break if scanner.eos?
            case
            when scanner.match?(/{{.+?}}/m)
              @plugins << scanner.matched
              scanner.pos += scanner.matched_size
            when scanner.match?(/\$.+?\$/)
              @math_notations << scanner.matched
              scanner.pos += scanner.matched_size
            else
              scanner.getch
            end
          end
          full_document
        end

        def postprocess(full_document)
          return full_document if @plugins.empty? && @math_notations.empty?
          document = ""
          scanner = StringScanner.new(full_document)
          loop do
            break if scanner.eos?
            case
            when scanner.match?(/{{.+?}}/m)
              document << @plugins.shift
              scanner.pos += scanner.matched_size
            when scanner.match?(/\$.+?\$/)
              document << @math_notations.shift
              scanner.pos += scanner.matched_size
            else
              document << scanner.getch
            end
          end
          document
        end

        def block_code(code, lang)
          if lang == "math"
            %Q(<div class="math">\n#{code}\n</div>)
          else
            super
          end
        end
      end
    end
  end
end
