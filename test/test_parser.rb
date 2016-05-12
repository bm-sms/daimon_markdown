require "helper"

class ParserTest < Test::Unit::TestCase

  data(
    "no args" => {
      str: "toc",
      name: "toc",
      args: []
    },
    "args" => {
      str: %Q(foo "bar", "baz"),
      name: "foo",
      args: ["bar", "baz"]
    },
    "args includes new line" => {
      str: %Q(foo "bar", "a\niueo|\nkaki"),
      name: "foo",
      args: ["bar", "a\niueo|\nkaki"]
    },
    "args with paren" => {
      str: %Q(foo("bar", "baz")),
      name: "foo",
      args: ["bar", "baz"]
    },
    "quotes" => {
      str: %Q(foo('ba"r', "a'iueo" )),
      name: "foo",
      args: ['ba"r', "a'iueo"]
    },
    "complex args" => {
      str: %Q(foo File, ["h]oge", "f[uga"], "bar", [1, 2.0, 0.4]),
      name: "foo",
      args: [File, ["h]oge", "f[uga"], "bar", [1, 2.0, 0.4]]
    },
    "nested array" => {
      str: %Q(foo [[0, 1], [2, 3]]),
      name: "foo",
      args: [[[0, 1], [2, 3]]]
    },
    "reserved key words" => {
      str: %Q(foo true, false, nil, "hoge"),
      name: "foo",
      args: [true, false, nil, "hoge"]
    }
  )
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
