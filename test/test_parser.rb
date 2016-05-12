require "helper"

class ParserTest < Test::Unit::TestCase

  data("no args" => {
         str: "toc",
         name: "toc",
         args: [],
       })
  def test_parser(data)
    str = data[:str]
    name = data[:name]
    args = data[:args]
    parser = Daimon::Markdown::Parser.new(str)
    parser.parse
    assert_equal(name, parser.name)
    assert_equal(args, parser.args)
  end
end
