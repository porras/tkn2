module Tkn2
  class Slide
    def initialize(*args)
      @args = args
    end

    def block
      ContentBlock.new(content)
    end

    def content
      Utils.strip_heredoc(raw_content)
    end

    def raw_content
      @args.first
    end

    class Center < Slide
      def content
        super.lines.map { |l| l.chomp.center(width) }.join("\n")
      end

      def width
        ContentBlock.new(Utils.strip_heredoc(raw_content)).width
      end
    end

    require 'pygments'

    class Code < Slide
      def lexer
        @args[1] || 'ruby'
      end

      def content
        # Pygments.highlight(super, formatter: 'terminal256', lexer: lexer)
        Pygments.highlight(super, formatter: 'terminal256', lexer: lexer, options: {style: 'bw'})
      end
    end

    class SectionHeader < Center
      def content
        line = ' ❧❦☙ '.center(width, '–')
        "#{line}\n\n#{super}\n\n#{line}"
      end
    end
  end

end
