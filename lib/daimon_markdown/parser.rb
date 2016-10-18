require "ripper"

module DaimonMarkdown
  class Parser < Ripper

    class Error < StandardError
    end

    KEYWORDS = {
      "nil" => nil,
      "true" => true,
      "false" => false
    }

    attr_reader :name, :args

    def initialize(src)
      super
      @name = nil
      @args = []
      @level = 0
      @array = []
      @arrays = {}
    end

    def on_vcall(name)
      @name = name
    end

    def on_command(name, *args)
      @name = name
    end

    def on_fcall(name)
      @name = name
    end

    def on_tstring_content(content)
      if @level == 0
        @args << content
      else
        @arrays[@level] << content
      end
    end

    def on_int(value)
      if @level == 0
        @args << value.to_i
      else
        @arrays[@level] << value.to_i
      end
    end

    def on_float(value)
      if @level == 0
        @args << value.to_f
      else
        @arrays[@level] << value.to_f
      end
    end

    def on_const(name)
      @args << Object.const_get(name)
    end

    def on_kw(keyword)
      @args << KEYWORDS[keyword]
    end

    def on_array(args)
      if @level == 0
        @args << @arrays[0].first
      end
    end

    def on_lbracket(*args)
      if @level == 0
        @arrays[0] = []
      end
      @level += 1
      @arrays[@level] = []
    end

    def on_rbracket(*args)
      @arrays[@level - 1] << @arrays[@level]
      @level -= 1
    end

    def on_parse_error(message)
      compile_error(message)
    end

    private

    def compile_error(message)
      raise Error, message
    end
  end
end
