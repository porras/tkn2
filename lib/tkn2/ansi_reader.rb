require 'stringio'

module Tkn2
  class ANSIReader
    SText = 0
    SCode = 1

    def parse(content)
      io = StringIO.new(content)
      state = SText
      buffer = ''
      while c = io.getc
        case state
        when SCode
          if c == 'm'
            code(buffer)
            state = SText
          else
            buffer << c
          end
        when SText
          if c == ?\e
            state = SCode
            buffer = ''
          else
            char(c)
          end
        end
      end
    end

    class Screen < ANSIReader
      def initialize(window)
        @window = window
      end

      def code(c)
        c.sub(/\A\[/, '').split(';').each do |n|
          @window.attrset(MAP[n]) if MAP[n]
        end
      end

      MAP = {
        "00" => Curses::A_NORMAL,
        "01" => Curses::A_BOLD,
      }

      def char(c)
        @window.addstr c
      end
    end

    class Remover < ANSIReader
      def remove(content)
        parse(content)
        string
      end

      def code(c)
      end

      def char(c)
        string << c
      end

      def string
        @string ||= ''
      end
    end
  end
end
