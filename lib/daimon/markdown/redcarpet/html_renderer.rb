require "rouge/plugins/redcarpet"

module Daimon
  module Markdown
    module Redcarpet
      class HTMLRenderer < ::Redcarpet::Render::HTML
        include Rouge::Plugins::Redcarpet
      end
    end
  end
end
