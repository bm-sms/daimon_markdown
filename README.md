# DaimonMarkdown

DaimonMarkdown is a Markdown processor that has plugin functionality.

## Installation

Add this line to your application's Gemfile:

**NOTICE** `daimon_markdown` has been renamed from `daimon-markdown` since v0.6.0.

```ruby
gem 'daimon_markdown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install daimon_markdown

## Usage

TODO: Write usage instructions here

```ruby
processor = DaimonMarkdown::Processor.new
result = processor.call(input)
puts result[:output].to_s
```

## How to write plugin

TODO

### Bundled plugins

#### toc

Display table of contents.

```
{{toc}}
```

#### figure

Display image using figure tag and figcaption tag.

```
{{figure("image.png", "alt text", "caption text")}}
```

#### math

Display mathematical expression using [MathJax](https://www.mathjax.org/).
Use 2 backslashes if you want to use commands start with backslash.

Currently support LaTeX and AsciiMath.

```text
# Inline style

This is a expression {{math("$1 + 1 = 2$")}}. And {{math("$2^{10} = 1024$")}} .

# Block style

{{math("$$
\begin{aligned}
\dot{x} & = \sigma(y-x) \\
\dot{y} & = \rho x - y - xz \\
\dot{z} & = -\beta z + xy
\end{aligned}
$$")}}
```


## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bm-sms/daimon_markdown.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

