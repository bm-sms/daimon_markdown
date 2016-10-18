require "rouge"
require "rouge/plugins/redcarpet"

module DaimonMarkdown
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
