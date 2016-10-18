require "cgi/util"

module DaimonMarkdown
  class Plugin
    class Base
      include CGI::Util

      attr_reader :doc, :node, :result, :context

      def initialize(doc, node, result, context)
        @doc = doc
        @node = node
        @result = result
        @context = context
      end

      def call(*args)
        raise "Implement this method in subclass"
      end
    end
  end
end
